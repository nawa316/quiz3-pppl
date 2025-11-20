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
                return null;
            }
            String sql = "SELECT * FROM jenis_kelamin WHERE kode = ?";
            // Menggunakan try-with-resources (PS & RS close otomatis, KONEKSI TETAP HIDUP)
            try (java.sql.PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setInt(1, kode);
                try (java.sql.ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        // Menggunakan nama kolom
                        int kodeJenisKelamin = rs.getInt("kode");
                        String namaJenisKelamin = rs.getString("nama");
                        
                        return new JenisKelaminObject(kodeJenisKelamin, namaJenisKelamin);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            return null;       
        }
        return null;
    }

    public boolean insert(JenisKelaminObject jenisKelamin){
        try {
            if (this.con == null) {
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
        return false;
    }

    public List<JenisKelaminObject> list(){
        List<JenisKelaminObject> list = new ArrayList<>();
        try {
            if (this.con == null) {
                return list;
            }
            String sql = "SELECT * FROM jenis_kelamin";
            try (java.sql.PreparedStatement ps = con.prepareStatement(sql)) {
                try (java.sql.ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) {
                        int kodeJenisKelamin = rs.getInt("kode");
                        String namaJenisKelamin = rs.getString("nama");
                        
                        list.add(new JenisKelaminObject(kodeJenisKelamin, namaJenisKelamin));
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            return list;       
        }
        return list;
    }
}
%>

<%! 
class JenisKelaminObject {
    int kode;
    String nama;
    
    // Constructor Kosong
    public JenisKelaminObject() {}

    // Constructor Lengkap (Baru)
    public JenisKelaminObject(int kode, String nama) {
        this.kode = kode;
        this.nama = nama;
    }
    
    public String getNama(){
        return this.nama;
    }
    
    public int getKode(){
        return this.kode;
    }
}
%>