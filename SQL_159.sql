SELECT B_DATETIME AS t, B_Q_ID AS q, B_V_ID AS v, B_VOL AS vol,
LAG(B_DATETIME, 1, NULL) OVER (PARTITION BY B_Q_ID, B_V_ID ORDER BY B_DATETIME, B_Q_ID, B_V_ID) AS tp, 
LAG(B_VOL, 1, NULL) OVER (PARTITION BY B_Q_ID, B_V_ID ORDER BY B_DATETIME, B_Q_ID, B_V_ID) AS volp
FROM utB