-- Returns model scores averaged over folds in StratifiedKFold for the specified experiment_group_id
SELECT dataset_name, model_type, model_parameters, metric_name, metric_k, avg(metric_score) AS avg_metric_score
FROM experiment_outputs
WHERE experiment_group_id = '851d78e2a33b586035715671295bd311' AND split_method = 'StratifiedKFold'
GROUP BY dataset_name, model_type, model_parameters, split_method, split_seed, split_num_fold, metric_name, metric_k

-- Returns best score for each model type for each metric
SELECT dataset_name, model_type, metric_name, metric_k, max(avg_metric_score) AS best_score
FROM
(
SELECT dataset_name, model_type, model_parameters, metric_name, metric_k, avg(metric_score) AS avg_metric_score
FROM experiment_outputs
WHERE experiment_group_id = '851d78e2a33b586035715671295bd311' AND split_method = 'StratifiedKFold'
GROUP BY dataset_name, model_type, model_parameters, split_method, split_num_fold, metric_name, metric_k
) model_scores
GROUP BY dataset_name, model_type, metric_name, metric_k
ORDER BY dataset_name, metric_name, metric_k, best_score DESC

-- Return the best model for a specified type, metric, and score 
SELECT dataset_name, model_type, model_parameters, avg_metric_score AS score
FROM 
(
SELECT dataset_name, model_type, model_parameters, metric_name, metric_k, avg(metric_score) AS avg_metric_score
FROM experiment_outputs
WHERE experiment_group_id = '851d78e2a33b586035715671295bd311' AND split_method = 'StratifiedKFold'
GROUP BY dataset_name, model_type, model_parameters, split_method, split_num_fold, metric_name, metric_k
) model_scores
WHERE model_type = 'XGB' AND metric_name = 'precision_score' AND metric_k = 25 AND avg_metric_score > 0.5509

