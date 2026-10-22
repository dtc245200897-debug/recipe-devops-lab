SET NAMES utf8mb4;

CREATE TABLE IF NOT EXISTS categories (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL UNIQUE
) CHARACTER SET utf8mb4;

CREATE TABLE IF NOT EXISTS recipes (
  id INT AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(200) NOT NULL,
  category_id INT NOT NULL,
  ingredients TEXT NOT NULL,
  instructions TEXT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (category_id) REFERENCES categories(id)
) CHARACTER SET utf8mb4;

INSERT INTO categories (name) VALUES ('Món chính'), ('Món canh'), ('Tráng miệng');

INSERT INTO recipes (title, category_id, ingredients, instructions) VALUES
('Thịt kho trứng', 1,
 '500g thịt ba chỉ\n5 quả trứng\n2 muỗng nước mắm\n1 muỗng đường\nNước dừa',
 'Luộc trứng, bóc vỏ.\nƯớp thịt với nước mắm và đường.\nKho thịt với nước dừa 40 phút, thêm trứng, kho thêm 15 phút.'),
('Canh chua cá', 2,
 '300g cá lóc\n2 quả cà chua\n1 quả dứa\nĐậu bắp, giá đỗ\nRau thơm',
 'Nấu nước với cà chua và dứa.\nCho cá vào nấu chín.\nThêm đậu bắp, giá, nêm nếm vừa ăn và rắc rau thơm.'),
('Chè đậu xanh', 3,
 '200g đậu xanh\n100g đường\n1 lít nước',
 'Ngâm đậu xanh 2 giờ.\nNấu đậu với nước đến khi mềm.\nThêm đường, nấu thêm 10 phút.');