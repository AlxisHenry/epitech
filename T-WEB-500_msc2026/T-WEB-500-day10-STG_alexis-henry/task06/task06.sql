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
