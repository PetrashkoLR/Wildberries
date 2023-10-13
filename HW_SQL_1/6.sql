SELECT substring(email FROM position ('@' IN email) + 1) AS most_popular_email, count(*) FROM users
WHERE gender = 'Male'
GROUP BY most_popular_email
ORDER BY count(*) DESC
LIMIT 3