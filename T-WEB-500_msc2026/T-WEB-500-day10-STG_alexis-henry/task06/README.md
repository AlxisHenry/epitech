# Setup

To run this project, you need to import the .sql file into mysql

```bash
cd <path to project>/task06/
sudo mysql # or any other way to access mysql
mysql> source task06.sql
```

Next, you need to change the database connection settings in the file `functions.php` to match your database settings.

```php
function pdo()
{
	$dbname = 'task06'; # If you imported the .sql file, then the database name is task06
	$username = '<your username>';
	$password = '<your password>';

	$pdo = null;
	try {
		$pdo = new PDO("mysql:host=localhost;dbname=$dbname;charset=utf8", $username, $password);
	} catch (PDOException $e) {
		echo "Ошибка при подключении к базе данных";
	}

	return $pdo;
}
```
