<%@ page import="java.sql.*" %>
<%!
class User {
	
	Connection con;
    UserObject user;
	
	User(Connection con){
		this.con = con;
	}
	
    public boolean login(UserLogin ul) {
        try {
            if (this.con == null) {
                System.err.println("Failed to create database connection.");
                return false;
            }
            String sql = "SELECT COUNT(*) FROM user WHERE username = ? AND password = MD5(?)";
            try (java.sql.PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setString(1, ul.username);
                ps.setString(2, ul.password);
                try (java.sql.ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        int count = rs.getInt(1);
                        return count > 0;
                    }
                }
            } 
                    } catch (Exception e) {
                        e.printStackTrace();
                        return false;        }
        // default: not authenticated
        return false;
    } 
	
	public UserObject get(String name){
        UserObject user;
          try {
            if (this.con == null) {
                System.err.println("Failed to create database connection.");
                return null;
            }
            String sql = "SELECT * FROM user WHERE username = ? ";
            try (java.sql.PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setString(1, name);
                try (java.sql.ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) {
                        String username = rs.getString(1);
                        String password = rs.getString(2);
                        int kode_role = rs.getInt(3);
                        user = new UserObject(username, password, kode_role);
                        return user;
                    }
                }
            } 
                    } catch (Exception e) {
                        e.printStackTrace();
                        return null;        }
        // default: not authenticated
		return null;
	}

    public boolean insert(UserObject user){
        try {
            if (this.con == null) {
                System.err.println("Failed to create database connection.");
                return false;
            }
            String sql = "INSERT INTO user (username, password, kode_role) VALUES (?, MD5(?), ?)";
            try (java.sql.PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setString(1, user.username);
                ps.setString(2, user.password);
                ps.setInt(3, user.kode_role);
                int rowsAffected = ps.executeUpdate();
                if (rowsAffected > 0) {
                    return true;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
        return false;
    }

    public boolean update(UserObject user){
        try {
            if (this.con == null) {
                System.err.println("Failed to create database connection.");
                return false;
            }
            String sql = "UPDATE user SET password = MD5(?), kode_role = ? WHERE username = ? ";
            try (java.sql.PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setString(1, user.password);
                ps.setInt(2, user.kode_role);
                ps.setString(3, user.username);
                int rowsAffected = ps.executeUpdate();
                if (rowsAffected > 0) {
                    return true;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
        return false;
    }

    public boolean delete(String username){
        try {
            if (this.con == null) {
                System.err.println("Failed to create database connection.");
                return false;
            }
            String sql = "DELETE FROM user WHERE username = ? ";
            try (java.sql.PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setString(1, username);
                int rowsAffected = ps.executeUpdate();
                if (rowsAffected > 0) {
                    return true;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;       
            }
        // default: not authenticated
        return false; 
    }

    public boolean updatePassword(String username, String newPassword){
        try {
            if (this.con == null) {
                System.err.println("Failed to create database connection.");
                return false;
            }
            String sql = "UPDATE user SET password = MD5(?) WHERE username = ? ";
            try (java.sql.PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setString(1, newPassword);
                ps.setString(2, username);
                int rowsAffected = ps.executeUpdate();
                if (rowsAffected > 0) {
                    return true;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
        return false;
    }

    public boolean updateKodeRole(String username, int newRole){
        try {
            if (this.con == null) {
                System.err.println("Failed to create database connection.");
                return false;
            }
            String sql = "UPDATE user SET kode_role = ? WHERE username = ? ";
            try (java.sql.PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setInt(1, newRole);
                ps.setString(2, username);
                int rowsAffected = ps.executeUpdate();
                if (rowsAffected > 0) {
                    return true;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
        return false;
    }

    public List<UserObject> listByKodeRole(int kode_role){
        List<UserObject> userList = new ArrayList<>();
          try {
            if (this.con == null) {
                System.err.println("Failed to create database connection.");
                return userList;
            }
            String sql = "SELECT * FROM user";
            try (java.sql.PreparedStatement ps = con.prepareStatement(sql)) {
                try (java.sql.ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) {
                        String username = rs.getString(1);
                        String password = rs.getString(2);
                        UserObject user = new UserObject(username, password, kode_role);
                        userList.add(user);
                    }
                }
            } 
          } catch (Exception e) {
            e.printStackTrace();
            return userList;
          }
        // default: not authenticated
        return userList;
    }

    public List<UserObject> list(){
    List<UserObject> userList = new ArrayList<>();
    try {
        if (this.con == null) {
            System.err.println("Failed to create database connection.");
            return userList;
        }

        String sql = "SELECT username, password, kode_role FROM user";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    String username = rs.getString("username");
                    String password = rs.getString("password");
                    int kode_role = rs.getInt("kode_role");
                    userList.add(new UserObject(username, password, kode_role));
                }
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return userList;
}

}
%>

<%! 
class UserLogin {
	public String username;
	public String password;
}
%>

<%! 

class UserObject {
	String username;
	String password;
	int kode_role;

    UserObject(){}

    UserObject(String username, String password, int kode_role){
        this.username = username;
        this.password = password;
        this.kode_role = kode_role;
    }
}
%>