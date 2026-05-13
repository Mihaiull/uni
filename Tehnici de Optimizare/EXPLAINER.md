# Power-Law Fitting with Gradient Descent
### Optimisation Techniques — Project Explainer

---

## What are we even trying to do?

You have **measurements** — for example, how fast something grows, how bright a star is at different distances, how prices scale with quantity. When you plot them they curve upward or downward in a specific way. You believe the data follows a **power law**:

```
y = a · x^b
```

- `a` is a **scale** — it stretches or squishes the curve up/down.
- `b` is the **exponent** — it controls how steeply the curve bends. If b < 1 it grows slower and slower (like a square root). If b > 1 it accelerates.

The problem: you don't know `a` or `b`. You need to **find the pair (a, b) that makes the curve fit the noisy data as tightly as possible.**

That is an **optimisation problem**.

---

## The loss function — "how wrong are we?"

For every data point `(x_i, y_i)` our model predicts `a · x_i^b`. The difference between prediction and reality is the **residual**:

```
r_i = y_i - a · x_i^b
```

We square each residual so that positives and negatives don't cancel, and sum them all up:

```
L(a, b) = (1/2) · Σ r_i²
```

This is the **loss** (also called cost or objective). A loss of zero means a perfect fit. We want to make it as small as possible — we want to **descend into the valley of this function**.

The (1/2) is just a notational convenience: when you differentiate a square you get a factor of 2, and the (1/2) cancels it out neatly.

---

## Why gradient descent?

Imagine you are blindfolded on a hilly landscape and you want to reach the lowest point. You can feel which direction the ground slopes downward under your feet — that is the **negative gradient**. If you always take a small step in that direction, you will eventually roll downhill into a valley.

That is gradient descent in one sentence: **step in the direction of steepest decrease, repeatedly, until you stop moving.**

Formally, at step k:

```
θ_{k+1} = θ_k − α · ∇L(θ_k)
```

where `θ = (a, b)` and `α` (alpha) is the step size.

---

## The gradients — which way is downhill?

We differentiate `L(a, b)` with respect to each parameter using the chain rule.

**With respect to a:**
```
∂L/∂a = −Σ r_i · x_i^b
```
Intuition: if we underpredict (residuals are positive) and we increase `a`, predictions go up and residuals shrink — gradient is negative, so GD increases `a`. Makes sense.

**With respect to b:**
```
∂L/∂b = −Σ r_i · a · x_i^b · ln(x_i)
```
The `ln(x_i)` comes from differentiating `x^b` with respect to `b`. This is just the power rule for exponents: d/db [x^b] = x^b · ln(x).

Both partials reuse the same `x_i^b` and `r_i` values, so the computation is cheap.

---

## The backtracking line search — picking the right step size

A fixed step size is dangerous:
- **Too large:** you overshoot the valley and bounce back and forth, or diverge completely.
- **Too small:** you creep along and need millions of iterations.

**Backtracking line search** picks the step size automatically at every iteration:

1. Start with a generous initial step `α₀ = 1.0`.
2. Check whether the loss actually dropped **enough** — this is the **Armijo condition**:
   ```
   L(θ − α·g) ≤ L(θ) − c · α · ‖g‖²
   ```
   The right-hand side is the decrease you'd expect if the landscape were a flat ramp tilted at angle c. It's a "minimum acceptable improvement" bar.
3. If the condition is not met, **shrink** `α` by half (`α ← 0.5 · α`) and check again.
4. Repeat until the condition holds, then take the step.

In practice this takes only 2–5 shrinks per iteration. The result is a step that is automatically calibrated to the local curvature of the landscape.

---

## Why is this problem non-convex?

The loss `L(a, b)` looks like a nice bowl when you look at it along the `a` direction — for fixed `b`, the problem is a simple linear least squares and has exactly one minimum.

But the `b` direction is **nonlinear and non-convex**: changing `b` reshapes the whole curve, and the loss surface has gentle ridges. Different starting points for `(a, b)` can converge to slightly different places, or at very different speeds. This is why the sensitivity-to-initialisation plot is interesting: it shows that the optimiser always converges, but how fast depends on where you start.

---

## Code walkthrough

| Section | What it does |
|---------|--------------|
| **1. Data generation** | Creates 100 points from the true power law, then adds Gaussian noise. The seed makes it reproducible. |
| **2. `loss(params, x, y)`** | Computes `L(a, b)` — the number we are trying to shrink. |
| **3. `gradient(params, x, y)`** | Returns the vector `[∂L/∂a, ∂L/∂b]` — the direction of steepest increase (we go the opposite way). |
| **4. `backtracking_line_search(...)`** | Tries step sizes halving until the Armijo condition holds; returns the accepted `α`. |
| **5. `gradient_descent(...)`** | Main loop: compute gradient, call line search, update parameters, record history, stop when gradient is tiny. |
| **6. Plots** | Three panels: fitted curve over data, loss vs iteration (log scale), gradient norm vs iteration. |
| **7. Sensitivity** | Reruns GD from four different starting points and overlays their convergence curves. |

---

## What to say when you present this

> "We have noisy data that we believe follows a power law. We define a loss function — the sum of squared residuals — and we want to find the parameters that minimise it. We use gradient descent: at each step we compute the gradient of the loss and move in the opposite direction. To avoid choosing a step size by hand, we use a backtracking line search that automatically shrinks the step until the Armijo sufficient-decrease condition is satisfied. The problem is non-convex in the exponent parameter, so convergence speed depends on initialisation — we illustrate this in the sensitivity plot. The algorithm converges in a few hundred iterations to parameters very close to the true ones, as confirmed by the fitted curve."

---

## Formulas cheat-sheet (for the board)

| Symbol | Meaning |
|--------|---------|
| `a, b` | Parameters we optimise |
| `h(x) = a·x^b` | Model prediction |
| `r_i = y_i − h(x_i)` | Residual for point i |
| `L = (1/2)·Σ r_i²` | Loss (objective to minimise) |
| `∂L/∂a = −Σ r_i · x_i^b` | Gradient w.r.t. a |
| `∂L/∂b = −Σ r_i · a · x_i^b · ln(x_i)` | Gradient w.r.t. b |
| `θ ← θ − α·∇L` | GD update rule |
| Armijo: `L(θ−αg) ≤ L(θ) − c·α·‖g‖²` | Sufficient-decrease condition |
