create index idx_countries_name on countries (name);

create index idx_employees_name_surname on employees (name, surname);

create unique index idx_employees_salary_range on employees (salary);

create index idx_employees_name_substring on employees ((substring(name from 1 for 4)));

create index idx_employees_departments_budget_salary on employees (salary);
create index idx_departments_budget on departments (budget);
