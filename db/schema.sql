SET timezone = 'America/New_York';

CREATE TYPE dataset_name_enum AS ENUM (
    'education', 'healthcare', 'housing'
);

CREATE TYPE split_method_enum AS ENUM (
    'StratifiedKFold', 'KFold', 'train_test_split'
);

CREATE TABLE experiment_outputs (
    experiment_output_id SERIAL PRIMARY KEY,
    experiment_group_id VARCHAR(64) NOT NULL,
    experiment_config_name VARCHAR(64) NOT NULL,
    dataset_name dataset_name_enum NOT NULL,
    model_type char(3) NOT NULL,
    model_parameters JSONB NOT NULL,
    sub_group JSONB,
    metric_name VARCHAR(64) NOT NULL,
    metric_k INTEGER,
    metric_score DECIMAL NOT NULL,
    split_method split_method_enum NOT NULL,
    split_seed INTEGER NOT NULL,
    split_num_fold INTEGER CHECK(split_num_fold > 0),
    split_num INTEGER NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
);
