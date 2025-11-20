<%@ page import="java.sql.*, java.util.*" %>
<%!
class Jenjang {
	
	Connection con;
	
	Jenjang(Connection con){
		this.con = con;
	}

	public JenjangObject get(int kode) {
		try {
			if (this.con == null) {
				System.err.println("Failed to create database connection.");
				return null;
			}
			String sql = "SELECT * FROM jenjang WHERE kode = ?";
			try (java.sql.PreparedStatement ps = con.prepareStatement(sql)) {
				ps.setInt(1, kode);
				try (java.sql.ResultSet rs = ps.executeQuery()) {
					if (rs.next()) {
						int kodeJenjang = rs.getInt(1);
						String namaJenjang = rs.getString(2);
						JenjangObject jenjang = new JenjangObject();
						jenjang.kode = kodeJenjang;
						jenjang.nama = namaJenjang;
						return jenjang;
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

	public boolean insert(JenjangObject jenjang){
		try {
			if (this.con == null) {
				System.err.println("Failed to create database connection.");
				return false;
			}
			String sql = "INSERT INTO jenjang (nama) VALUES (?) ";
			try (java.sql.PreparedStatement ps = con.prepareStatement(sql)) {
				ps.setString(1, jenjang.getNama());
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

	public List<JenjangObject> list(){
		List<JenjangObject> list = new ArrayList<>();
		try {
			if (this.con == null) {
				System.err.println("Failed to create database connection.");
				return list;
			}
			String sql = "SELECT * FROM jenjang";
			try (java.sql.PreparedStatement ps = con.prepareStatement(sql)) {
				try (java.sql.ResultSet rs = ps.executeQuery()) {
					while (rs.next()) {
						int kodeJenjang = rs.getInt(1);
						String namaJenjang = rs.getString(2);
						JenjangObject jenjang = new JenjangObject();
						jenjang.kode = kodeJenjang;
						jenjang.nama = namaJenjang;
						list.add(jenjang);
					}
				}
			} finally {
				try { if (con != null && !con.isClosed()) con.close(); } catch (Exception ignored) {}
			}
					} catch (Exception e) {
						e.printStackTrace();
						return list;       
			}
		// default: not authenticated
		return list;
	}

	public boolean update(JenjangObject jenjang){
		try {
			if (this.con == null) {
				System.err.println("Failed to create database connection.");
				return false;
			}
			String sql = "UPDATE jenjang SET nama = ? WHERE kode = ? ";
			try (java.sql.PreparedStatement ps = con.prepareStatement(sql)) {
				ps.setString(1, jenjang.getNama());
				ps.setInt(2, jenjang.getKode());
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

	public boolean delete(int kode){
		try {
			if (this.con == null) {
				System.err.println("Failed to create database connection.");
				return false;
			}
			String sql = "DELETE FROM jenjang WHERE kode = ? ";
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
}
%>

<%! 
class JenjangObject {
	
	int kode;
	String nama;

	public int getKode() {
		return kode;
	}

	public void setKode(int kode) {
		this.kode = kode;
	}

	public String getNama() {
		return nama;
	}

	public void setNama(String nama) {
		this.nama = nama;
	}
}
%>