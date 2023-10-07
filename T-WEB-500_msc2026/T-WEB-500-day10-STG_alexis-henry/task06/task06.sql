SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

DROP DATABASE IF EXISTS `task06`;
CREATE DATABASE `task06` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;

USE `task06`;

DROP TABLE IF EXISTS `authors`;
CREATE TABLE `authors` (
`id` int(11) AUTO_INCREMENT PRIMARY KEY,
`name` varchar(255) NOT NULL,
`created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `authors` (`id`, `name`, `created_at`) VALUES
(1, 'John Doe', '2023-10-04 15:02:00'),
(2, 'Jane Doe', '2023-10-03 19:02:00');

DROP TABLE IF EXISTS `messages`;
CREATE TABLE `messages` (
`id` int(11) AUTO_INCREMENT PRIMARY KEY,
`content` varchar(255) NOT NULL,
`author_id` varchar(255) NOT NULL,
`created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Create a lot of messages with random content and author
INSERT INTO `messages` (`id`, `content`, `author_id`, `created_at`) VALUES
(1, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla euismod, nisl quis aliquam ultricies, nunc nisl
ultricies nunc, quis aliquam nisl nisl nec nisl. Sed euismod, nisl quis aliquam ultricies, nunc nisl ultricies nunc,
quis aliquam nisl nisl nec nisl.', 1, '2023-10-04 15:02:00'),
(2, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla euismod, nisl quis aliquam ultricies, nunc nisl
ultricies nunc, quis aliquam nisl nisl nec nisl. Sed euismod, nisl quis aliquam ultricies, nunc nisl ultricies nunc,
quis aliquam nisl nisl nec nisl.', 1, '2023-10-04 15:02:00'),
(3, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla euismod, nisl quis aliquam ultricies, nunc nisl
ultricies nunc, quis aliquam nisl nisl nec nisl. Sed euismod, nisl quis aliquam ultricies, nunc nisl ultricies nunc,
quis aliquam nisl nisl nec nisl.', 2, '2023-10-03 19:02:00'),
(4, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla euismod, nisl quis aliquam ultricies, nunc nisl
ultricies nunc, quis aliquam nisl nisl nec nisl. Sed euismod, nisl quis aliquam ultricies, nunc nisl ultricies nunc,
quis aliquam nisl nisl nec nisl.', 1, '2023-10-02 18:02:00'),
(5, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla euismod, nisl quis aliquam ultricies, nunc nisl
ultricies nunc, quis aliquam nisl nisl nec nisl. Sed euismod, nisl quis aliquam ultricies, nunc nisl ultricies nunc,
quis aliquam nisl nisl nec nisl.', 2, '2023-10-01 21:30:00'),
(6, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla euismod, nisl quis aliquam ultricies, nunc nisl
ultricies nunc, quis aliquam nisl nisl nec nisl. Sed euismod, nisl quis aliquam ultricies, nunc nisl ultricies nunc,
quis aliquam nisl nisl nec.', 2, '2023-10-06 22:02:00');

DROP TABLE IF EXISTS `comments`;
CREATE TABLE `comments` (
`id` int(11) AUTO_INCREMENT PRIMARY KEY,
`content` varchar(255) NOT NULL,
`author` varchar(255) NOT NULL,
`created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `comments` (`id`, `content`, `author`, `created_at`) VALUES
(1, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla euismod, nisl quis aliquam ultricies, nunc nisl', 'Alexis', '2023-10-04 20:20:20'),
(2, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla euismod, nisl quis aliquam ultricies, nunc nisl', 'Alexis', '2023-10-05 22:20:20'),
(3, 'consectetur adipiscing elit. Nulla euismod, nisl quis aliquam ultricies, nunc nisl', 'Alexis2', '2023-10-08 23:22:10'),
(4, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla euismod, nisl quis aliquam ultricies, nunc nisl', 'Alexis', '2023-10-01 20:20:20'),
(5, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla euismod, nisl quis aliquam ultricies, nunc nisl', 'Alexis', '2023-08-03 22:20:20'),
(6, 'consectetur adipiscing elit. Nulla euismod, nisl quis aliquam ultricies, nunc nisl', 'Alexis2', '2023-08-04 23:22:10'),
(7, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla euismod, nisl quis aliquam ultricies, nunc nisl', 'Alexis', '2023-10-04 20:20:20'),
(8, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla euismod, nisl quis aliquam ultricies, nunc nisl', 'Alexis', '2023-10-05 22:20:20'),
(9, 'consectetur adipiscing elit. Nulla euismod, nisl quis aliquam ultricies, nunc nisl', 'Alexis2', '2023-10-08 23:22:10'),
(10, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla euismod, nisl quis aliquam ultricies, nunc nisl', 'Alexis', '2023-10-01 20:20:20'),
(11, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla euismod, nisl quis aliquam ultricies, nunc nisl', 'Alexis', '2023-08-03 22:20:20'),
(12, 'consectetur adipiscing elit. Nulla euismod, nisl quis aliquam ultricies, nunc nisl', 'Alexis2', '2023-08-04 23:22:10'),
(13, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla euismod, nisl quis aliquam ultricies, nunc nisl', 'Alexis', '2023-10-04 20:20:20'),
(14, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla euismod, nisl quis aliquam ultricies, nunc nisl', 'Alexis', '2023-10-05 22:20:20'),
(15, 'consectetur adipiscing elit. Nulla euismod, nisl quis aliquam ultricies, nunc nisl', 'Alexis2', '2023-10-08 23:22:10'),
(16, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla euismod, nisl quis aliquam ultricies, nunc nisl', 'Alexis', '2023-10-01 20:20:20'),
(17, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla euismod, nisl quis aliquam ultricies, nunc nisl', 'Alexis', '2023-08-03 22:20:20'),
(18, 'consectetur adipiscing elit. Nulla euismod, nisl quis aliquam ultricies, nunc nisl', 'Alexis2', '2023-08-04 23:22:10'),
(19, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla euismod, nisl quis aliquam ultricies, nunc nisl', 'Alexis', '2023-10-04 20:20:20'),
(20, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla euismod, nisl quis aliquam ultricies, nunc nisl', 'Alexis', '2023-10-05 22:20:20'),
(21, 'consectetur adipiscing elit. Nulla euismod, nisl quis aliquam ultricies, nunc nisl', 'Alexis2', '2023-10-08 23:22:10'),
(22, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla euismod, nisl quis aliquam ultricies, nunc nisl', 'Alexis', '2023-10-01 20:20:20'),
(23, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla euismod, nisl quis aliquam ultricies, nunc nisl', 'Alexis', '2023-08-03 22:20:20'),
(24, 'consectetur adipiscing elit. Nulla euismod, nisl quis aliquam ultricies, nunc nisl', 'Alexis2', '2023-08-04 23:22:10');