// admin.js — Admin dashboard script (ES6 module)
// Contains reusable helpers and page-specific functions.

const API_BASE = '/api';

function showAlert(container, message, type = 'success') {
  const el = document.createElement('div');
  el.className = `alert alert-${type} mt-2`;
  el.textContent = message;
  container.prepend(el);
  setTimeout(() => el.remove(), 4000);
}

function renderTable(columns, rows = []) {
  const table = document.createElement('table');
  table.className = 'table table-sm table-striped';
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

// Employees
async function fetchEmployees() {
  const resp = await fetch(`${API_BASE}/employees`);
  if (!resp.ok) throw new Error('Failed to load employees');
  return resp.json();
}

async function loadEmployees() {
  const container = document.getElementById('employeesTableContainer');
  container.innerHTML = '<div class="text-muted">Loading employees...</div>';
  try {
    const data = await fetchEmployees();
    // Map data to table-friendly rows (assuming API returns camelCase fields)
    const rows = data.map(emp => ({
      'ID': emp.id,
      'Name': `${emp.first_name} ${emp.last_name}`,
      'Position': emp.position_name || '',
      'Department': emp.department_name || '',
      'Actions': `<button class="btn btn-sm btn-primary" data-id="${emp.id}">Edit</button> <button class="btn btn-sm btn-danger" data-id="${emp.id}">Delete</button>`
    }));
    container.innerHTML = '';
    container.appendChild(renderTable(['ID','Name','Position','Department','Actions'], rows));
  } catch (err) {
    container.innerHTML = '<div class="text-danger">Unable to load employees.</div>';
  }
}

// Positions and Departments would follow similar patterns
async function fetchPositions() { return (await fetch(`${API_BASE}/positions`)).json(); }
async function fetchDepartments() { return (await fetch(`${API_BASE}/departments`)).json(); }

async function loadPositions() {
  const container = document.getElementById('positionsTableContainer');
  container.innerHTML = '<div class="text-muted">Loading positions...</div>';
  try {
    const data = await fetchPositions();
    const rows = data.map(p => ({ 'ID': p.id, 'Title': p.title, 'Actions': `<button class="btn btn-sm btn-primary" data-id="${p.id}">Edit</button>` }));
    container.innerHTML = '';
    container.appendChild(renderTable(['ID','Title','Actions'], rows));
  } catch (err) { container.innerHTML = '<div class="text-danger">Unable to load positions.</div>'; }
}

async function loadDepartments() {
  const container = document.getElementById('departmentsTableContainer');
  container.innerHTML = '<div class="text-muted">Loading departments...</div>';
  try {
    const data = await fetchDepartments();
    const rows = data.map(d => ({ 'ID': d.id, 'Name': d.name, 'Actions': `<button class="btn btn-sm btn-primary" data-id="${d.id}">Edit</button>` }));
    container.innerHTML = '';
    container.appendChild(renderTable(['ID','Name','Actions'], rows));
  } catch (err) { container.innerHTML = '<div class="text-danger">Unable to load departments.</div>'; }
}

// Wire up basic buttons (placeholders for full CRUD modals)
document.addEventListener('DOMContentLoaded', () => {
  loadEmployees();
  loadPositions();
  loadDepartments();

  document.getElementById('addEmployeeBtn').addEventListener('click', () => {
    showAlert(document.querySelector('main'), 'Open employee create form (not implemented in UI).', 'info');
  });
  document.getElementById('addPositionBtn').addEventListener('click', () => showAlert(document.querySelector('main'), 'Open position create form (not implemented).', 'info'));
  document.getElementById('addDepartmentBtn').addEventListener('click', () => showAlert(document.querySelector('main'), 'Open department create form (not implemented).', 'info'));
});

/* Laravel migration notes:
 - Create controllers: Admin\\EmployeeController with index/store/update/destroy methods.
 - Replace `fetch` calls with blade-rendered initial data or use API routes under `routes/api.php`.
 - Move `renderTable()` into a Blade component (e.g., `components.table`).
*/
