<%@ page import="java.sql.*, java.util.*" %>
<%!
class JenisKelamin {
	
	Connection con;
	
	JenisKelamin(Connection con){
		this.con = con;
	}

	public JenisKelaminObject get(int kode) {
		try {
			if (this.con == null) {
				System.err.println("Failed to create database connection.");
				return null;
			}
			String sql = "SELECT * FROM jenis_kelamin WHERE kode = ?";
			try (java.sql.PreparedStatement ps = con.prepareStatement(sql)) {
				ps.setInt(1, kode);
				try (java.sql.ResultSet rs = ps.executeQuery()) {
					if (rs.next()) {
						int kodeJenisKelamin = rs.getInt(1);
						String namaJenisKelamin = rs.getString(2);
						JenisKelaminObject jenisKelamin = new JenisKelaminObject();
						jenisKelamin.kode = kodeJenisKelamin;
						jenisKelamin.nama = namaJenisKelamin;
						return jenisKelamin;
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

	public boolean insert(JenisKelaminObject jenisKelamin){
		try {
			if (this.con == null) {
				System.err.println("Failed to create database connection.");
				return false;
			}
			String sql = "INSERT INTO jenis_kelamin (nama) VALUES (?) ";
			try (java.sql.PreparedStatement ps = con.prepareStatement(sql)) {
				ps.setString(1, jenisKelamin.getNama());
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

	public boolean update(JenisKelaminObject jenisKelamin){
		try {
			if (this.con == null) {
				System.err.println("Failed to create database connection.");
				return false;
			}
			String sql = "UPDATE jenis_kelamin SET nama = ? WHERE kode = ? ";
			try (java.sql.PreparedStatement ps = con.prepareStatement(sql)) {
				ps.setString(1, jenisKelamin.getNama());
				ps.setInt(2, jenisKelamin.getKode());
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
			String sql = "DELETE FROM jenis_kelamin WHERE kode = ? ";
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

	public List<JenisKelaminObject> list(){
		List<JenisKelaminObject> list = new ArrayList<>();
		try {
			if (this.con == null) {
				System.err.println("Failed to create database connection.");
				return list;
			}
			String sql = "SELECT * FROM jenis_kelamin";
			try (java.sql.PreparedStatement ps = con.prepareStatement(sql)) {
				try (java.sql.ResultSet rs = ps.executeQuery()) {
					while (rs.next()) {
						int kodeJenisKelamin = rs.getInt(1);
						String namaJenisKelamin = rs.getString(2);
						JenisKelaminObject jenisKelamin = new JenisKelaminObject();
						jenisKelamin.kode = kodeJenisKelamin;
						jenisKelamin.nama = namaJenisKelamin;
						list.add(jenisKelamin);
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
}
%>

<%! 
class JenisKelaminObject {
	int kode;
	String nama;
	
	public String getNama(){
		return this.nama;
	}
	
	public int getKode(){
		return this.kode;
	}
}
%>