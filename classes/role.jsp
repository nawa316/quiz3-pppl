<%@ page import="java.sql.*" %>
<%!
class Role {
	
	Connection con;
	
	Role(Connection con){
		this.con = con;
	}

	public RoleObject get(int kode) {
        try {
            if (this.con == null) {
                System.err.println("Failed to create database connection.");
                return null;
            }
            String sql = "SELECT * FROM role WHERE kode = ?";
            try (java.sql.PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setInt(1, kode);
                try (java.sql.ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
						int kodeRole = rs.getInt(1);
						String namaRole = rs.getString(2);
                        RoleObject role = new RoleObject(kodeRole, namaRole);
                    }
                }
            } finally {
                try { if (con != null && !con.isClosed()) con.close(); } catch (Exception ignored) {}
            }
                    } catch (Exception e) {
                        e.printStackTrace();
                        return null;       
			}
        // default: not authenticated
        return null;
    } 
	
	public boolean update(RoleObject role){
		try {
			if (this.con == null) {
				System.err.println("Failed to create database connection.");
				return false;
			}
			String sql = "UPDATE role SET nama = ? WHERE kode = ? ";
			try (java.sql.PreparedStatement ps = con.prepareStatement(sql)) {
				ps.setString(1, role.nama);
				ps.setInt(2, role.kode);
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

	public boolean insert(RoleObject role){
		try {
			if (this.con == null) {
				System.err.println("Failed to create database connection.");
				return false;
			}
			String sql = "INSERT INTO role (nama) VALUES ( ? ) ";
			try (java.sql.PreparedStatement ps = con.prepareStatement(sql)) {
				ps.setString(1, role.nama);
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

	public boolean delete(int kode){
		try {
			if (this.con == null) {
				System.err.println("Failed to create database connection.");
				return false;
			}
			String sql = "DELETE FROM role WHERE kode = ? ";
			try (java.sql.PreparedStatement ps = con.prepareStatement(sql)) {
				ps.setInt(1, kode);
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

	public List<RoleObject> list(){
		List<RoleObject> roles = new ArrayList<>();
		try {
			if (this.con == null) {
				System.err.println("Failed to create database connection.");
				return roles;
			}
			String sql = "SELECT * FROM role ";
			try (java.sql.PreparedStatement ps = con.prepareStatement(sql)) {
				try (java.sql.ResultSet rs = ps.executeQuery()) {
					while (rs.next()) {
						int kode = rs.getInt(1);
						String nama = rs.getString(2);
						RoleObject role = new RoleObject(kode, nama);
						roles.add(role);
					}
				}
			} finally {
				try { if (con != null && !con.isClosed()) con.close(); } catch (Exception ignored) {}
			}
					} catch (Exception e) {
						e.printStackTrace();
						return roles;       
			}
		// default: not authenticated
		return roles;
	}
}
%>

<%! 
class RoleObject {
	int kode;
	String nama;
	RoleObject(){}

	RoleObject(int kode, String nama){
		this.kode = kode;
		this.nama = nama;
	}
}
%>