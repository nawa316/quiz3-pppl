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
                return null;
            }
            String sql = "SELECT * FROM prodi WHERE kode = ?";
            // Menggunakan try-with-resources untuk PreparedStatement & ResultSet
            // Koneksi (con) TIDAK DITUTUP
            try (java.sql.PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setInt(1, kode);
                try (java.sql.ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        // Menggunakan nama kolom agar lebih aman
                        int kodeProdi = rs.getInt("kode");
                        String namaProdi = rs.getString("nama");
                        int kodeJenjang = rs.getInt("kode_jenjang");
                        
                        ProdiObject prodi = new ProdiObject(kodeProdi, namaProdi, kodeJenjang);
                        return prodi;
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            return null;       
        }
        return null;
    }

    public boolean insert(ProdiObject prodi){
        try {
            if (this.con == null) {
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
                return false;
            }
            String sql = "UPDATE prodi SET nama = ?, kode_jenjang = ? WHERE kode = ? ";
            try (java.sql.PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setString(1, prodi.getNama());
                ps.setInt(2, prodi.getKode_jenjang());
                ps.setInt(3, prodi.getKode()); // Parameter WHERE
                
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
        return false;
    }

    public List<ProdiObject> list(){
        List<ProdiObject> list = new ArrayList<>();
        try {
            if (this.con == null) {
                return list;
            }
            String sql = "SELECT * FROM prodi ";
            try (java.sql.PreparedStatement ps = con.prepareStatement(sql)) {
                try (java.sql.ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) {
                        int kodeProdi = rs.getInt("kode");
                        String namaProdi = rs.getString("nama");
                        int kodeJenjang = rs.getInt("kode_jenjang");
                        
                        ProdiObject prodi = new ProdiObject(kodeProdi, namaProdi, kodeJenjang);
                        list.add(prodi);
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
            // PERBAIKAN: Sebelumnya return this.kode_jenjang (salah)
            return this.kode; 
        }
        
        public String getNama(){
            return this.nama;
        }

        public int getKode_jenjang(){
            return this.kode_jenjang;
        }
    }
%>