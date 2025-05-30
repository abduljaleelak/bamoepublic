--
-- User tasks subsystem tables
--

-- TABLE jbpm_user_tasks: The entity that represents a User Task
-- id: The User Task ID. The scope of this ID is valid on the User Tasks subsystem only. Can't be used at the Workflow Engine level
-- user_task_id: The ID of the node associated with this User Task
-- status: The status name
-- termination_type: COMPLETED, ABORT, FAILED, EXITED, OBSOLETE, ERROR
-- external_reference_id: The ID of the Work Item associated with this user task. Can be used at Workflow Engine lever to refer to this User Task

CREATE TABLE jbpm_user_tasks (
    id VARCHAR2(50) NOT NULL,
    user_task_id VARCHAR2(255),
    task_priority VARCHAR2(50),
    actual_owner VARCHAR2(255),
    task_description VARCHAR2(255),
    status VARCHAR2(255),
    termination_type VARCHAR2(255),
    external_reference_id VARCHAR2(255),
    task_name VARCHAR2(255),
    CONSTRAINT jbpm_user_tasks_pkey PRIMARY KEY (id)
);

-- TABLE jbpm_user_tasks_potential_users
CREATE TABLE jbpm_user_tasks_potential_users (
    task_id VARCHAR2(50) NOT NULL,
    user_id VARCHAR2(255) NOT NULL,
    CONSTRAINT jbpm_user_tasks_potential_users_pkey PRIMARY KEY (task_id, user_id),
    CONSTRAINT fk_jbpm_user_fk_tasks_potential_users_tid FOREIGN KEY (task_id)  REFERENCES jbpm_user_tasks(id) ON DELETE CASCADE
);

-- TABLE jbpm_user_tasks_potential_groups
CREATE TABLE jbpm_user_tasks_potential_groups (
    task_id VARCHAR2(50) NOT NULL,
    group_id VARCHAR2(255) NOT NULL,
    CONSTRAINT jbpm_user_tasks_potential_groups_pkey PRIMARY KEY (task_id, group_id),
    CONSTRAINT fk_jbpm_user_tasks_potential_groups_tid FOREIGN KEY (task_id)  REFERENCES jbpm_user_tasks(id) ON DELETE CASCADE
);

-- TABLE jbpm_user_tasks_admin_users
CREATE TABLE jbpm_user_tasks_admin_users (
    task_id VARCHAR2(50) NOT NULL,
    user_id VARCHAR2(255) NOT NULL,
    CONSTRAINT jbpm_user_tasks_admin_users_pkey PRIMARY KEY (task_id, user_id),
    CONSTRAINT fk_jbpm_user_tasks_admin_users_tid FOREIGN KEY (task_id)  REFERENCES jbpm_user_tasks(id) ON DELETE CASCADE
);

-- TABLE jbpm_user_tasks_admin_groups
CREATE TABLE jbpm_user_tasks_admin_groups (
    task_id VARCHAR2(50) NOT NULL,
    group_id VARCHAR2(255) NOT NULL,
    CONSTRAINT jbpm_user_tasks_admin_groups_pkey PRIMARY KEY (task_id, group_id),
    CONSTRAINT fk_jbpm_user_tasks_admin_groups_tid FOREIGN KEY (task_id) REFERENCES jbpm_user_tasks(id) ON DELETE CASCADE
);

-- TABLE jbpm_user_tasks_excluded_users
CREATE TABLE jbpm_user_tasks_excluded_users (
    task_id VARCHAR2(50) NOT NULL,
    user_id VARCHAR2(255) NOT NULL,
    CONSTRAINT jbpm_user_tasks_excluded_users_pkey PRIMARY KEY (task_id, user_id),
    CONSTRAINT fk_jbpm_user_tasks_excluded_users_tid FOREIGN KEY (task_id) REFERENCES jbpm_user_tasks(id) ON DELETE CASCADE
);

-- TABLE jbpm_user_tasks_attachments: An attachment is a reference to an external URIs containing information relevant to a related task, for example a screen snapshot.
-- url: The uri related to this attachment
CREATE TABLE jbpm_user_tasks_attachments (
    id VARCHAR2(50) NOT NULL,
    name VARCHAR2(255),
    updated_by VARCHAR2(255),
    updated_at timestamp(6),
    url VARCHAR2(255),
    task_id VARCHAR2(50) NOT NULL,
    CONSTRAINT jbpm_user_tasks_attachments_pkey PRIMARY KEY (id),
    CONSTRAINT fk_user_tasks_attachments_tid FOREIGN KEY (task_id) REFERENCES jbpm_user_tasks(id) ON DELETE CASCADE
);

-- TABLE jbpm_user_tasks_comments: A comment consists of a human readable text that will help to achieve a successful resolution of a task.
-- comment: The comment related to this attachment
CREATE TABLE jbpm_user_tasks_comments (
    id VARCHAR2(50) NOT NULL,
    updated_by VARCHAR2(255),
    updated_at timestamp(6),
    task_comment VARCHAR2(1000),
    task_id VARCHAR2(50) NOT NULL,
    CONSTRAINT jbpm_user_tasks_comments_pkey PRIMARY KEY (id),
    CONSTRAINT fk_user_tasks_comments_tid FOREIGN KEY (task_id) REFERENCES jbpm_user_tasks(id) ON DELETE CASCADE
);

-- TABLE jbpm_user_tasks_inputs: Input parameters of a task which are passed as a pair (name, value), to be consumed by a human
CREATE TABLE jbpm_user_tasks_inputs (
    task_id VARCHAR2(50) NOT NULL,
    input_name VARCHAR2(255) NOT NULL,
    input_value BLOB,
    java_type VARCHAR2(255),
    CONSTRAINT jbpm_user_tasks_inputs_pkey PRIMARY KEY (task_id, input_name),
    CONSTRAINT fk_jbpm_user_tasks_inputs_tid FOREIGN KEY (task_id) REFERENCES jbpm_user_tasks(id) ON DELETE CASCADE
);

-- TABLE jbpm_user_tasks_outputs: Output parameters of a User Task, which results in a set of properties in a pair (name, value) format.
CREATE TABLE jbpm_user_tasks_outputs (
    task_id VARCHAR2(50) NOT NULL,
    output_name VARCHAR2(255) NOT NULL,
    output_value BLOB,
    java_type VARCHAR2(255),
    CONSTRAINT jbpm_user_tasks_outputs_pkey PRIMARY KEY (task_id, output_name),
    CONSTRAINT fk_jbpm_user_tasks_outputs_tid FOREIGN KEY (task_id) REFERENCES jbpm_user_tasks(id) ON DELETE CASCADE
);

-- TABLE jbpm_user_tasks_metadata: Global properties related the User Task
CREATE TABLE jbpm_user_tasks_metadata (
    task_id VARCHAR2(50),
    metadata_name VARCHAR2(255) NOT NULL,
    metadata_value VARCHAR2(512),
    java_type VARCHAR2(255),
    CONSTRAINT jbpm_user_tasks_metadata_pkey PRIMARY KEY (task_id, metadata_name),
    CONSTRAINT fk_jbpm_user_tasks_metadata_tid FOREIGN KEY (task_id) REFERENCES jbpm_user_tasks(id) ON DELETE CASCADE
);

-- TABLE jbpm_user_tasks_deadline:
CREATE TABLE jbpm_user_tasks_deadline (
    id NUMBER(10),
    task_id VARCHAR2(50) NOT NULL,
    notification_type VARCHAR2(255) NOT NULL,
    notification_value BLOB,
    java_type VARCHAR2(255),
    CONSTRAINT jbpm_user_tasks_deadline_pkey PRIMARY KEY (id),
    CONSTRAINT fk_jbpm_user_tasks_deadline_tid FOREIGN KEY (task_id) REFERENCES jbpm_user_tasks(id) ON DELETE CASCADE
);

-- TABLE jbpm_user_tasks_reassignment:
CREATE TABLE jbpm_user_tasks_reassignment (
    id NUMBER(10),
    task_id VARCHAR2(50) NOT NULL,
    reassignment_type VARCHAR2(255) NOT NULL,
    reassignment_value BLOB,
    java_type VARCHAR2(255),
    CONSTRAINT jbpm_user_tasks_reassignment_pkey PRIMARY KEY (id),
    CONSTRAINT fk_jbpm_user_tasks_reassignment_tid FOREIGN KEY (task_id) REFERENCES jbpm_user_tasks(id) ON DELETE CASCADE
);

-- TABLE jbpm_user_tasks_deadline_timer:
CREATE TABLE jbpm_user_tasks_deadline_timer (
    task_id VARCHAR2(50) NOT NULL,
    notification_job_id VARCHAR2(255) NOT NULL,
    notification_type VARCHAR2(255) NOT NULL,
    notification_value BLOB,
    java_type VARCHAR2(255),
    CONSTRAINT jbpm_user_tasks_deadline_timer_pkey PRIMARY KEY (task_id, notification_job_id),
    CONSTRAINT fk_jbpm_user_tasks_deadline_timer_tid FOREIGN KEY (task_id) REFERENCES jbpm_user_tasks(id) ON DELETE CASCADE
);

-- TABLE jbpm_user_tasks_reassignment_timer:
CREATE TABLE jbpm_user_tasks_reassignment_timer (
    task_id VARCHAR2(50) NOT NULL,
    reassignment_job_id VARCHAR2(255) NOT NULL,
    reassignment_type VARCHAR2(255) NOT NULL,
    reassignment_value BLOB,
    java_type VARCHAR2(255),
    CONSTRAINT jbpm_user_tasks_reassignment_timer_pkey PRIMARY KEY (task_id, reassignment_job_id),
    CONSTRAINT fk_jbpm_user_tasks_reassignment_timer_tid FOREIGN KEY (task_id) REFERENCES jbpm_user_tasks(id) ON DELETE CASCADE
);

CREATE SEQUENCE jbpm_user_tasks_deadline_seq
    START WITH 1
    INCREMENT BY 50
    CACHE 50;

CREATE SEQUENCE jbpm_user_tasks_reassignment_seq
    START WITH 1
    INCREMENT BY 50
    CACHE 50;
