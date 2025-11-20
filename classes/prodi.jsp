<%@ page import="java.sql.*, java.util.*" %>
<%!
class Prodi {
	
	Connection con;
	
	Prodi(Connection con){
		this.con = con;
	}

	public ProdiObject get(int kode) {
		try {
			if (this.con == null) {
				System.err.println("Failed to create database connection.");
				return null;
			}
			String sql = "SELECT * FROM prodi WHERE kode = ?";
			try (java.sql.PreparedStatement ps = con.prepareStatement(sql)) {
				ps.setInt(1, kode);
				try (java.sql.ResultSet rs = ps.executeQuery()) {
					if (rs.next()) {
						int kodeProdi = rs.getInt(1);
						String namaProdi = rs.getString(2);
						int kodeJenjang = rs.getInt(3);
						ProdiObject prodi = new ProdiObject(kodeProdi, namaProdi, kodeJenjang);
						return prodi;
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

	public boolean insert(ProdiObject prodi){
		try {
			if (this.con == null) {
				System.err.println("Failed to create database connection.");
				return false;
			}
			String sql = "INSERT INTO prodi (nama, kode_jenjang) VALUES (?, ?)";
			try (java.sql.PreparedStatement ps = con.prepareStatement(sql)) {
				ps.setString(1, prodi.getNama());
				ps.setInt(2, prodi.getKode_jenjang());
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

	public boolean update(ProdiObject prodi){
		try {
			if (this.con == null) {
				System.err.println("Failed to create database connection.");
				return false;
			}
			String sql = "UPDATE prodi SET nama = ? WHERE kode = ? ";
			try (java.sql.PreparedStatement ps = con.prepareStatement(sql)) {
				ps.setString(1, prodi.getNama());
				ps.setInt(2, prodi.getKode());
				ps.setInt(3, prodi.getKode_jenjang());
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
			String sql = "DELETE FROM prodi WHERE kode = ? ";
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

	public List<ProdiObject> list(){
		List<ProdiObject> list = new ArrayList<>();
		try {
			if (this.con == null) {
				System.err.println("Failed to create database connection.");
				return list;
			}
			String sql = "SELECT * FROM prodi ";
			try (java.sql.PreparedStatement ps = con.prepareStatement(sql)) {
				try (java.sql.ResultSet rs = ps.executeQuery()) {
					while (rs.next()) {
						int kodeProdi = rs.getInt(1);
						String namaProdi = rs.getString(2);
						int kodeJenjang = rs.getInt(3);
						ProdiObject prodi = new ProdiObject(kodeProdi, namaProdi, kodeJenjang	);
						list.add(prodi);
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
	class ProdiObject {
		int kode;
		String nama;
		int kode_jenjang;
		
		ProdiObject(){
		}
		
		ProdiObject(int kode, String nama, int kode_jenjang){
			this.kode = kode;
			this.nama = nama;
			this.kode_jenjang = kode_jenjang;
		}
		
		public int getKode(){
			return this.kode_jenjang;
		}
		
		public String getNama(){
			return this.nama;
		}

		public int getKode_jenjang(){
			return this.kode_jenjang;
		}
	}
%>