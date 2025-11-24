// staff.js — Staff dashboard script (ES6 module)
// Staff can view applicants and update status.

const API_BASE = '/api';

function showAlert(container, message, type = 'success') {
  const el = document.createElement('div');
  el.className = `alert alert-${type} mt-2`;
  el.textContent = message;
  container.prepend(el);
  setTimeout(() => el.remove(), 3500);
}

function renderTable(columns, rows = []) {
  const table = document.createElement('table');
  table.className = 'table table-sm table-hover';
  const thead = document.createElement('thead');
  const tr = document.createElement('tr');
  columns.forEach(c => { const th = document.createElement('th'); th.textContent = c; tr.appendChild(th); });
  thead.appendChild(tr);
  table.appendChild(thead);

  const tbody = document.createElement('tbody');
  rows.forEach(r => {
    const tr = document.createElement('tr');
    columns.forEach(col => {
      const td = document.createElement('td');
      td.innerHTML = r[col] ?? '';
      tr.appendChild(td);
    });
    tbody.appendChild(tr);
  });
  table.appendChild(tbody);
  return table;
}

async function fetchApplicants() {
  const resp = await fetch(`${API_BASE}/applicants`);
  if (!resp.ok) throw new Error('Failed to fetch applicants');
  return resp.json();
}

async function updateApplicantStatus(id, status) {
  const resp = await fetch(`${API_BASE}/applicants/${id}`, {
    method: 'PUT',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ status })
  });
  if (!resp.ok) throw new Error('Failed to update status');
  return resp.json();
}

async function loadApplicants() {
  const container = document.getElementById('applicantsTableContainer');
  container.innerHTML = '<div class="text-muted">Loading applicants...</div>';
  try {
    const data = await fetchApplicants();
    const rows = data.map(a => ({
      'ID': a.id,
      'Name': `${a.first_name} ${a.last_name}`,
      'Email': a.email,
      'Status': `<select class="form-select form-select-sm status-select" data-id="${a.id}"><option ${a.status==='screened'?'selected':''} value="screened">screened</option><option ${a.status==='shortlisted'?'selected':''} value="shortlisted">shortlisted</option><option ${a.status==='hired'?'selected':''} value="hired">hired</option><option ${a.status==='rejected'?'selected':''} value="rejected">rejected</option></select>`
    }));
    container.innerHTML = '';
    container.appendChild(renderTable(['ID','Name','Email','Status'], rows));

    // wire up change handlers
    container.querySelectorAll('.status-select').forEach(sel => {
      sel.addEventListener('change', async (e) => {
        const id = e.target.dataset.id;
        const status = e.target.value;
        try {
          await updateApplicantStatus(id, status);
          showAlert(container, 'Status updated', 'success');
        } catch (err) {
          showAlert(container, 'Failed to update status', 'danger');
        }
      });
    });
  } catch (err) {
    container.innerHTML = '<div class="text-danger">Unable to load applicants.</div>';
  }
}

document.addEventListener('DOMContentLoaded', () => {
  loadApplicants();
});

/* Laravel migration notes:
 - Controller: Staff\\ApplicantController@index and updateStatus.
 - Use Form Requests to validate status change.
*/
