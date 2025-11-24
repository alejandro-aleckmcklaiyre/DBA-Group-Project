// index.js — Login logic (ES6 module)
// This file should be migrated to a Laravel controller / auth flow.

// Point to the example PHP endpoint created at `php/admin/auth.php`.
// Resolve relative to the current page so the endpoint works whether the
// project is served from the webroot or a subfolder (XAMPP htdocs).
// When you migrate to Laravel, set this to `/api/login` or the appropriate route.
const apiLoginEndpoint = new URL('../php/admin/auth.php', window.location.href).href; // Backend endpoint for local XAMPP setup

/**
 * showAlert - reusable small alert renderer
 * container: element to prepend the alert into
 * message: string
 * type: bootstrap type
 */
function showAlert(container, message, type = 'success') {
  const el = document.createElement('div');
  el.className = `alert alert-${type} mt-2`;
  el.setAttribute('role', 'alert');
  el.textContent = message;
  const alertContainer = container.querySelector('#alertContainer') || container;
  alertContainer.prepend(el);
  setTimeout(() => el.remove(), 4500);
}

function getCsrfTokenFromMeta() {
  // When moving to Blade, include: <meta name="csrf-token" content="{{ csrf_token() }}">
  const m = document.querySelector('meta[name="csrf-token"]');
  return m ? m.getAttribute('content') : null;
}

async function postLogin(payload) {
  // Example login POST. Laravel typically accepts form data or JSON at /login or /api/login
  const headers = { 'Content-Type': 'application/json' };
  const csrf = getCsrfTokenFromMeta();
  if (csrf) headers['X-CSRF-TOKEN'] = csrf;

  const resp = await fetch(apiLoginEndpoint, {
    method: 'POST',
    headers,
    body: JSON.stringify(payload),
    credentials: 'include' // allow cookies for session based auth
  });
  return resp;
}

function disableButton(btn, state = true) {
  btn.disabled = state;
  if (state) {
    btn.dataset.orig = btn.innerHTML;
    btn.innerHTML = '<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> Logging in...';
  } else if (btn.dataset.orig) {
    btn.innerHTML = btn.dataset.orig;
    delete btn.dataset.orig;
  }
}

document.getElementById('loginForm').addEventListener('submit', async (e) => {
  e.preventDefault();
  const form = e.target;
  const container = document.querySelector('.card-body');
  const email = document.getElementById('email').value.trim();
  const password = document.getElementById('password').value;
  const role = document.getElementById('role').value;
  const loginBtn = document.getElementById('loginBtn');

  // Basic client-side validation
  if (!email || !password) {
    showAlert(container, 'Email and password are required.', 'warning');
    return;
  }

  disableButton(loginBtn, true);
  try {
    // Call server endpoint. Backend should validate credentials and return JSON e.g. { success:true, role:'admin', token:'...', user: {...} }
    const resp = await postLogin({ email, password });

    if (resp.ok) {
      const data = await resp.json().catch(() => ({}));
      // Accept server-provided role if present; otherwise fall back to the dropdown (demo)
      const userRole = data.role || role;

      // Save token if provided (consider secure HttpOnly cookies in production instead)
      if (data.token) localStorage.setItem('hris_token', data.token);
      if (data.user) localStorage.setItem('hris_user', JSON.stringify(data.user));
      localStorage.setItem('hris_role', userRole);

      showAlert(container, 'Login successful — redirecting...', 'success');
      // Redirect based on role (server should always enforce this)
      setTimeout(() => {
        if (userRole === 'admin') window.location.href = 'admin.html';
        else if (userRole === 'staff') window.location.href = 'staff.html';
        else window.location.href = 'applicant.html';
      }, 700);
    } else if (resp.status === 422) {
      // validation error
      const body = await resp.json().catch(() => ({}));
      showAlert(container, body.message || 'Invalid credentials.', 'warning');
    } else if (resp.status === 405) {
      showAlert(container, 'Method not allowed (405). The endpoint may not accept POST at this URL. Check the Network tab for the request URL and ensure `php/admin/auth.php` is reachable via POST.', 'danger');
    } else {
      // Non-JSON responses (404, 500) may return an HTML error page or empty body.
      const text = await resp.text().catch(() => null);
      const message = text ? text : `Login failed (status ${resp.status}).`;
      showAlert(container, message, 'danger');
    }
  } catch (err) {
    showAlert(container, 'Network error — could not reach server.', 'danger');
  } finally {
    disableButton(loginBtn, false);
  }
});

// Export small utilities for later import by other modules or tests
export { showAlert, postLogin };

/*
  Laravel migration notes:
  - Replace the client-side POST with a Blade form that posts to `{{ route('login') }}` or implement `routes/api.php` login endpoint.
  - Use `web` middleware and session-based auth for server-side redirects. If using API tokens, return token and set secure HttpOnly cookie from server.
  - Add `<meta name="csrf-token" content="{{ csrf_token() }}">` into `layouts/app.blade.php` so JS can pick it up.
*/
