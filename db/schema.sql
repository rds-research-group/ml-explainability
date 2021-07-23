SET timezone = 'America/New_York';

CREATE TYPE model_type_enum AS ENUM (
    'linear_regression', 'decision_tree', 'random_forest', 'xgboost'
);

CREATE TYPE dataset_type_enum AS ENUM (
    'education', 'healthcare', 'housing'
);

CREATE TYPE metric_type_enum AS ENUM (
    'roc_auc', 'accuracy', 'precision'
);

CREATE TYPE split_method_enum AS ENUM (
    'stratified_k_fold', 'k_fold'
);

CREATE TABLE experiment_models (
    model_id SERIAL PRIMARY KEY,
    model_type model_type_enum NOT NULL,
    split_seed INTEGER NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    dataset_type dataset_type_enum NOT NULL,
    k_threshold_percentage INTEGER,
    metric_type metric_type_enum NOT NULL,
    model_parameters JSONB NOT NULL,
    split_method split_method_enum NOT NULL,
    split_n INTEGER NOT NULL,
    sub_group VARCHAR(64) NOT NULL,
    score DECIMAL NOT NULL
);
