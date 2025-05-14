-- 刀 AI 数据库扩展技术 - 演示数据库模式
-- 本文件定义了演示系统使用的数据库表结构。
-- 注意：此 SQL 文件仅用于演示目的，不会在实际数据库中执行。

-- 创建数据库（模拟）
CREATE DATABASE IF NOT EXISTS dao_ai_demo
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE dao_ai_demo;

-- 性能指标表
-- 用于存储监控代理收集的性能指标
CREATE TABLE performance_metrics (
    metric_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    timestamp DATETIME NOT NULL,
    query_execution_time FLOAT, -- 查询执行时间（秒）
    cpu_usage FLOAT, -- CPU 使用率（%）
    memory_usage FLOAT, -- 内存使用率（%）
    disk_io INT, -- 磁盘 I/O（KB/s）
    query_count INT, -- 查询计数
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_timestamp (timestamp)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 优化日志表
-- 用于存储优化执行器的操作记录
CREATE TABLE optimization_logs (
    log_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    timestamp DATETIME NOT NULL,
    action VARCHAR(50) NOT NULL, -- 优化动作（例如 create_index）
    success BOOLEAN NOT NULL, -- 操作是否成功
    execution_time FLOAT, -- 执行时间（秒）
    estimated_impact JSON, -- 预计影响（如查询时间减少）
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_action (action)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 用户数据表
-- 用于存储模拟的用户数据，供查询优化测试
CREATE TABLE user_data (
    user_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    last_access DATETIME,
    INDEX idx_username (username)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 预测结果表
-- 用于存储预测分析引擎的预测结果
CREATE TABLE prediction_results (
    prediction_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    timestamp DATETIME NOT NULL,
    anomaly_detected BOOLEAN, -- 是否检测到异常
    anomaly_score FLOAT, -- 异常得分
    workload_prediction JSON, -- 工作负载预测
    optimization_suggestion JSON, -- 优化建议
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_timestamp (timestamp)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 插入示例数据
INSERT INTO performance_metrics (timestamp, query_execution_time, cpu_usage, memory_usage, disk_io, query_count)
VALUES 
    (NOW(), 0.5, 45.2, 60.1, 500, 10),
    (NOW(), 1.2, 50.3, 65.4, 600, 15);

INSERT INTO optimization_logs (timestamp, action, success, execution_time, estimated_impact)
VALUES 
    (NOW(), 'create_index', TRUE, 0.3, '{"query_time_reduction": 20.5}'),
    (NOW(), 'partition_data', FALSE, 0.8, '{"query_time_reduction": 15.0}');

INSERT INTO user_data (username, email, last_access)
VALUES 
    ('user1', 'user1@example.com', NOW()),
    ('user2', 'user2@example.com', NOW());

INSERT INTO prediction_results (timestamp, anomaly_detected, anomaly_score, workload_prediction, optimization_suggestion)
VALUES 
    (NOW(), FALSE, 0.85, '{"predicted_query_time": 0.6}', '{"action": "create_index", "confidence": 0.95}'),
    (NOW(), TRUE, 0.97, '{"predicted_query_time": 1.5}', '{"action": "rewrite_query", "confidence": 0.90}');

-- 添加注释
COMMENT ON TABLE performance_metrics IS '存储监控代理收集的性能指标，用于分析数据库性能';
COMMENT ON TABLE optimization_logs IS '记录优化执行器的操作历史，用于跟踪优化效果';
COMMENT ON TABLE user_data IS '模拟用户数据，用于测试查询和优化策略';
COMMENT ON TABLE prediction_results IS '存储预测分析引擎的预测结果，支持持续学习';