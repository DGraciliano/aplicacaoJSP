<%

//Conexão com MySql

Class.forName("com.mysql.jdbc.Driver");

Connection connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/dipes_disst_seguranca?useTimezone=true&serverTimezone=UTC", "root", "");

Statement st = connect.createStatement();

Statement st0 = connect.createStatement();

Statement st1 = connect.createStatement();

Statement st2 = connect.createStatement();

Statement st3 = connect.createStatement();

Statement st4 = connect.createStatement();

Statement st5 = connect.createStatement();

Statement st6 = connect.createStatement();

Statement st7 = connect.createStatement();

Statement st8 = connect.createStatement();

Statement st9 = connect.createStatement();

Statement st10 = connect.createStatement();

PreparedStatement ps = null;

%>
