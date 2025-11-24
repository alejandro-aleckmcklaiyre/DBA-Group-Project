// applicant.js — Applicant portal script (ES6 module)
// Handles registration and viewing own application status.

const API_BASE = '/api';

function showAlert(container, message, type = 'success') {
  const el = document.createElement('div');
  el.className = `alert alert-${type} mt-2`;
  el.textContent = message;
  container.prepend(el);
  setTimeout(() => el.remove(), 4000);
}

async function registerApplicant(payload) {
  const resp = await fetch(`${API_BASE}/applicants`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify(payload)
  });
  if (!resp.ok) throw new Error('Registration failed');
  return resp.json();
}

async function fetchApplicantStatus(id) {
  const resp = await fetch(`${API_BASE}/applicants/${id}`);
  if (!resp.ok) throw new Error('Failed to load applicant');
  return resp.json();
}

document.getElementById('applicantForm').addEventListener('submit', async (e) => {
  e.preventDefault();
  const payload = {
    first_name: document.getElementById('first_name').value.trim(),
    last_name: document.getElementById('last_name').value.trim(),
    email: document.getElementById('email').value.trim(),
    resume: document.getElementById('resume').value.trim(),
  };

  try {
    const saved = await registerApplicant(payload);
    showAlert(document.querySelector('.card-body'), 'Registered successfully', 'success');
    // after register, show simple status
    document.getElementById('applicationStatus').textContent = saved.status || 'submitted';
    // store applicant id locally for demo; real app will use auth/session
    localStorage.setItem('applicant_id', saved.id);
  } catch (err) {
    showAlert(document.querySelector('.card-body'), 'Registration failed', 'danger');
  }
});

// Load applicant status if present
(function loadExistingStatus() {
  const id = localStorage.getItem('applicant_id');
  if (!id) return;
  fetchApplicantStatus(id).then(a => {
    document.getElementById('applicationStatus').textContent = a.status || 'submitted';
    // populate fields (readonly) if needed
  }).catch(() => {
    /* ignore */
  });
})();

/* Laravel migration notes:
 - Store applicant via `ApplicantController@store` and return JSON or redirect.
 - Use Laravel Auth for applicant sessions and `auth()->id()` to lookup status.
*/
