"""
Power-Law Nonlinear Least Squares via Gradient Descent
with Backtracking Line Search
=====================================================
Optimisation Techniques — course project

We want to find the best (a, b) such that:
    h(x; a, b) = a * x^b
fits a noisy dataset as closely as possible.

"Best" means minimising the sum of squared errors between
what our model predicts and what we actually observed.
"""

import numpy as np
import matplotlib
# matplotlib.use("Agg")          # non-interactive backend — no display required
import matplotlib.pyplot as plt
import matplotlib.gridspec as gridspec

# ──────────────────────────────────────────────────────────────
# 1.  DATA GENERATION
# ──────────────────────────────────────────────────────────────

RNG_SEED   = 42          # fix so results are reproducible
N_POINTS   = 1000         # number of (x, y) observations
X_MIN      = 0.5         # avoid x = 0 (would make log undefined)
X_MAX      = 100.0
TRUE_A     = 2.5         # ground-truth scale parameter
TRUE_B     = 0.8         # ground-truth exponent
NOISE_STD  = 0.7        # standard deviation of measurement noise

rng = np.random.default_rng(RNG_SEED)

x_data = rng.uniform(X_MIN, X_MAX, N_POINTS)
# True signal plus Gaussian noise
y_data = TRUE_A * x_data ** TRUE_B + rng.normal(0, NOISE_STD, N_POINTS)


# ──────────────────────────────────────────────────────────────
# 2.  OBJECTIVE FUNCTION AND GRADIENT
# ──────────────────────────────────────────────────────────────

def loss(params, x, y):
    """
    L(a, b) = (1/2) * sum_i ( y_i - a * x_i^b )^2

    The (1/2) factor is a convention that cancels the 2
    from squaring when we differentiate — keeps formulas tidy.

    Returns np.inf for numerically degenerate parameter values so
    that the backtracking line search safely rejects those candidates.
    """
    a, b = params
    with np.errstate(over="ignore", invalid="ignore"):
        residuals = y - a * x ** b      # how far off each prediction is
        val = 0.5 * np.dot(residuals, residuals)
    return val if np.isfinite(val) else np.inf


def gradient(params, x, y):
    """
    Partial derivatives of L with respect to a and b:

        dL/da = -sum_i  r_i * x_i^b
        dL/db = -sum_i  r_i * a * x_i^b * ln(x_i)

    where r_i = y_i - a * x_i^b  (the residual).

    Both use the same x^b and residual values, so we compute
    them once and reuse — no wasted work.
    """
    a, b = params
    with np.errstate(over="ignore", invalid="ignore"):
        xb        = x ** b                               # x_i^b  (shared across both partials)
        residuals = y - a * xb                           # r_i

        dL_da = -np.dot(residuals, xb)                  # chain rule for a
        dL_db = -np.dot(residuals, a * xb * np.log(x))  # chain rule for b (log from d/db x^b)

    return np.array([dL_da, dL_db])


# ──────────────────────────────────────────────────────────────
# 3.  BACKTRACKING LINE SEARCH  (Armijo condition)
# ──────────────────────────────────────────────────────────────
#
# Plain gradient descent uses a fixed step size.  If the step
# is too large we overshoot; if too small we crawl forever.
# Backtracking solves this automatically:
#   - Start with a generous step alpha_0.
#   - Shrink by factor rho until the loss drops "enough".
# "Enough" is formalised by the Armijo sufficient-decrease condition:
#
#   L(theta - alpha * g) <= L(theta) - c * alpha * ||g||^2
#
# c is a small constant (1e-4 is standard).  The right-hand side
# is the expected decrease if the loss were linear and we moved
# a fraction c of the way down the gradient direction.

def backtracking_line_search(params, grad, x, y,
                             alpha0=1.0, rho=0.5, c=1e-4):
    """
    Returns the step size alpha satisfying the Armijo condition.

    alpha0 : initial (maximum) step size to try
    rho    : how aggressively to shrink (0.5 = halve each time)
    c      : sufficient-decrease fraction (tiny; 1e-4 is safe)
    """
    alpha      = alpha0
    loss_curr  = loss(params, x, y)
    grad_sq    = np.dot(grad, grad)          # ||g||^2  — target drop proportional to this

    # Safety valve: 100 halvings → alpha shrinks to alpha0 / 2^100 ≈ 0
    for _ in range(100):
        candidate = params - alpha * grad
        if loss(candidate, x, y) <= loss_curr - c * alpha * grad_sq:
            break                            # condition satisfied — accept step
        alpha *= rho                         # step too large, shrink and retry

    return alpha


# ──────────────────────────────────────────────────────────────
# 4.  GRADIENT DESCENT LOOP
# ──────────────────────────────────────────────────────────────

def gradient_descent(x, y,
                     theta_init,
                     max_iter=2000,
                     tol=1e-6,
                     alpha0=1.0, rho=0.5, c=1e-4):
    """
    Runs GD with backtracking line search from theta_init.

    Returns a history dict for plotting:
        - 'params'   : array of (a, b) at each iteration
        - 'losses'   : loss value at each iteration
        - 'alphas'   : step size chosen at each iteration
        - 'grad_norms': ||gradient|| at each iteration
    """
    theta = np.array(theta_init, dtype=float)

    history = {
        "params":     [theta.copy()],
        "losses":     [loss(theta, x, y)],
        "alphas":     [],
        "grad_norms": [],
    }

    for _ in range(max_iter):
        g = gradient(theta, x, y)
        gnorm = np.linalg.norm(g)
        history["grad_norms"].append(gnorm)

        if gnorm < tol:
            # Gradient is essentially zero — we are at (or very near) a minimum.
            break

        alpha = backtracking_line_search(theta, g, x, y, alpha0, rho, c)
        theta = theta - alpha * g           # the actual GD update

        history["params"].append(theta.copy())
        history["losses"].append(loss(theta, x, y))
        history["alphas"].append(alpha)

    return theta, history


# ──────────────────────────────────────────────────────────────
# 5.  RUN THE OPTIMISER
# ──────────────────────────────────────────────────────────────

# Initialise far from the truth to make convergence visible
theta_init = [1.0, 0.1]

theta_opt, hist = gradient_descent(
    x_data, y_data,
    theta_init=theta_init,
    max_iter=2000,
    tol=1e-7,
)

a_opt, b_opt = theta_opt
print(f"True parameters :  a = {TRUE_A},   b = {TRUE_B}")
print(f"Fitted parameters: a = {a_opt:.4f}, b = {b_opt:.4f}")
print(f"Final loss       : {hist['losses'][-1]:.6f}")
print(f"Iterations ran   : {len(hist['losses']) - 1}")


# ──────────────────────────────────────────────────────────────
# 6.  PLOTS
# ──────────────────────────────────────────────────────────────

iters = np.arange(len(hist["losses"]))

fig = plt.figure(figsize=(14, 10))
fig.suptitle("Power-Law Fitting via GD + Backtracking Line Search", fontsize=14, y=1.01)
gs = gridspec.GridSpec(2, 2, hspace=0.45, wspace=0.35)


# — Plot 1: Data, ground truth, and fitted curve ——————————————
ax1 = fig.add_subplot(gs[0, :])   # spans both columns

x_plot = np.linspace(X_MIN, X_MAX, 300)
ax1.scatter(x_data, y_data, s=18, alpha=0.6, color="steelblue", label="Noisy observations")
ax1.plot(x_plot, TRUE_A * x_plot ** TRUE_B, "k--", lw=2,
         label=f"Ground truth  $y={TRUE_A}x^{{{TRUE_B}}}$")
ax1.plot(x_plot, a_opt * x_plot ** b_opt, "crimson", lw=2,
         label=f"Fitted curve  $y={a_opt:.3f}x^{{{b_opt:.3f}}}$")
ax1.set_xlabel("x")
ax1.set_ylabel("y")
ax1.set_title("Curve Fit Result")
ax1.legend()


# — Plot 2: Loss vs iteration (log scale) ————————————————————
ax2 = fig.add_subplot(gs[1, 0])

ax2.semilogy(iters, hist["losses"], color="darkorange", lw=1.5)
ax2.set_xlabel("Iteration")
ax2.set_ylabel("Loss  L(a, b)  [log scale]")
ax2.set_title("Convergence of Loss")
ax2.grid(True, which="both", linestyle="--", alpha=0.5)


# — Plot 3: Gradient norm vs iteration ———————————————————————
ax3 = fig.add_subplot(gs[1, 1])

ax3.semilogy(np.arange(len(hist["grad_norms"])), hist["grad_norms"],
             color="seagreen", lw=1.5)
ax3.set_xlabel("Iteration")
ax3.set_ylabel("‖∇L‖  [log scale]")
ax3.set_title("Gradient Norm (convergence criterion)")
ax3.grid(True, which="both", linestyle="--", alpha=0.5)


plt.savefig("power_law_fitting.png", dpi=150, bbox_inches="tight")
plt.show()
print("Plots saved to power_law_fitting.png")


# ──────────────────────────────────────────────────────────────
# 7.  OPTIONAL: SENSITIVITY TO INITIALISATION
#     Shows that because the landscape is non-convex in b,
#     bad starting points can converge slowly or to a worse spot.
# ──────────────────────────────────────────────────────────────

starts = [
    ([1.0,  0.1],  "Start A  (a=1.0, b=0.1)"),
    ([5.0,  1.5],  "Start B  (a=5.0, b=1.5)"),
    ([0.5,  0.3],  "Start C  (a=0.5, b=0.3)"),
    ([3.0,  0.8],  "Start D  (a=3.0, b=0.8)"),
]

fig2, ax = plt.subplots(figsize=(8, 5))
for init, label in starts:
    _, h = gradient_descent(x_data, y_data, theta_init=init, max_iter=2000, tol=1e-7)
    ax.semilogy(np.arange(len(h["losses"])), h["losses"], lw=1.5, label=label)

ax.set_xlabel("Iteration")
ax.set_ylabel("Loss  L(a, b)  [log scale]")
ax.set_title("Sensitivity to Initialisation")
ax.legend(fontsize=8)
ax.grid(True, which="both", linestyle="--", alpha=0.5)

plt.tight_layout()
plt.savefig("power_law_sensitivity.png", dpi=150, bbox_inches="tight")
plt.show()
print("Sensitivity plot saved to power_law_sensitivity.png")
