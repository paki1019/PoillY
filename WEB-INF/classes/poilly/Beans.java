package poilly;

import java.sql.*;
import java.util.*;

public class Beans {

	Connection conn = null;
	PreparedStatement pstmt = null;

	String jdbc_driver = "com.mysql.jdbc.Driver";
	String jdbc_url = "jdbc:mysql://nasosdb.cehnqm7jclum.ap-northeast-2.rds.amazonaws.com/PoillY?useUnicode=true&characterEncoding=utf8";

	void connect() {
		try {
			Class.forName(jdbc_driver);

			conn = DriverManager.getConnection(jdbc_url, "paki1019", "kmy37950224!");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	void disconnect() {
		if (pstmt != null) {
			try {
				pstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		if (conn != null) {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

	public boolean insertPost(PoillY_Post post) {
		connect();

		String sql = "INSERT INTO post(title,writer,star,spoiller,movie,contents,writer_id) VALUES(?,?,?,?,?,?,?)";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, post.getTitle());
			pstmt.setString(2, post.getWriter());
			pstmt.setInt(3, post.getStar());
			pstmt.setInt(4, post.getSpoiller());
			pstmt.setString(5, post.getMovie());
			pstmt.setString(6, post.getContents());
			pstmt.setString(7, post.getWriter_id());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			disconnect();
		}
		return true;
	}

	public boolean deletePost(String post_id) {
		connect();
		String sql = "DELETE FROM post WHERE id=?";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, post_id);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			disconnect();
		}
		return true;
	}

	public boolean updatePost(PoillY_Post post) {
		connect();

		String sql = "UPDATE post SET title=?, writer=?, star=?, spoiller=?,time=?,view=?,contents=? WHERE id=?";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, post.getTitle());
			pstmt.setString(2, post.getWriter());
			pstmt.setInt(3, post.getStar());
			pstmt.setInt(4, post.getSpoiller());
			pstmt.setString(5, post.getTime());
			pstmt.setInt(6, post.getView());
			pstmt.setString(7, post.getContents());
			pstmt.setInt(8, post.getId());
			System.out.println(pstmt);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			disconnect();
		}
		return true;
	}

	public PoillY_Post getPost(String post_id) {
		connect();

		String sql = "SELECT * FROM post WHERE id= ?";
		PoillY_Post post = new PoillY_Post();

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, post_id);
			ResultSet rs = pstmt.executeQuery();

			rs.next();
			post.setId(rs.getInt("id"));
			post.setTitle(rs.getString("title"));
			post.setWriter(rs.getString("writer"));
			post.setStar(rs.getInt("star"));
			post.setSpoiller(rs.getInt("spoiller"));
			post.setTime(rs.getString("time"));
			post.setView(rs.getInt("view"));
			post.setMovie(rs.getString("movie"));
			post.setContents(rs.getString("contents"));
			post.setWriter_id(rs.getString("writer_id"));
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			disconnect();
		}
		return post;
	}

	public ArrayList<PoillY_Post> getPostList(String post_movie, int first, int last) {
		connect();
		ArrayList<PoillY_Post> datas = new ArrayList<PoillY_Post>();

		String sql = "SELECT * FROM post WHERE movie = ? ORDER BY id DESC limit ?, ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, post_movie);
			pstmt.setInt(2, first);
			pstmt.setInt(3, last);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				PoillY_Post post = new PoillY_Post();

				post.setId(rs.getInt("id"));
				post.setTitle(rs.getString("title"));
				post.setWriter(rs.getString("writer"));
				post.setStar(rs.getInt("star"));
				post.setSpoiller(rs.getInt("spoiller"));
				post.setTime(rs.getString("time"));
				post.setView(rs.getInt("view"));

				post.setMovie(rs.getString("movie"));
				post.setWriter_id(rs.getString("writer_id"));
				datas.add(post);
			}
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			disconnect();
		}
		return datas;

	}

	public boolean insertMovie(PoillY_Movie movie) {
		connect();

		String sql = "INSERT INTO movie(title,image,story) VALUES(?,?,?)";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, movie.getTitle());
			pstmt.setString(2, movie.getImage());
			pstmt.setString(3, movie.getStory());
			System.out.println(pstmt);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			disconnect();
		}
		return true;
	}

	public boolean updateMoviestar(String movie) {
		connect();

		String sql = "UPDATE movie SET star = (SELECT avg(star) FROM post WHERE movie = ?) WHERE title = ?";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, movie);
			pstmt.setString(2, movie);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			disconnect();
		}
		return true;
	}
	public PoillY_Movie getMoviebyName(String movie_name) {
		connect();

		String sql = "SELECT * FROM movie WHERE title=?";
		PoillY_Movie movie = new PoillY_Movie();

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, movie_name);
			ResultSet rs = pstmt.executeQuery();

			rs.next();
			movie.setId(rs.getInt("id"));
			movie.setTitle(rs.getString("title"));
			movie.setStar(rs.getFloat("star"));
			movie.setImage(rs.getString("image"));
			movie.setStory(rs.getString("story"));
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			disconnect();
		}
		return movie;
	}

	public PoillY_Movie getMovie(int movie_id) {
		connect();

		String sql = "SELECT * FROM movie WHERE id=?";
		PoillY_Movie movie = new PoillY_Movie();

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, movie_id);
			ResultSet rs = pstmt.executeQuery();

			rs.next();
			movie.setId(rs.getInt("id"));
			movie.setTitle(rs.getString("title"));
			movie.setStar(rs.getFloat("star"));
			movie.setImage(rs.getString("image"));
			movie.setStory(rs.getString("story"));

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			disconnect();
		}
		return movie;
	}

	public ArrayList<PoillY_Movie> getMovieList() {
		connect();
		ArrayList<PoillY_Movie> datas = new ArrayList<PoillY_Movie>();
		String sql = "SELECT * FROM movie ORDER BY id ASC";
		try {
			pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				PoillY_Movie movie = new PoillY_Movie();

				movie.setId(rs.getInt("id"));
				movie.setTitle(rs.getString("title"));
				movie.setStar(rs.getFloat("star"));
				movie.setImage(rs.getString("image"));
				movie.setStory(rs.getString("story"));
				datas.add(movie);
			}
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			disconnect();
		}
		return datas;
	}

	public boolean doSign(PoillY_Account account) {
		connect();
		String sql = "INSERT INTO account(id,password,nickname) VALUES(?,?,?)";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, account.getID());
			pstmt.setString(2, account.getPassword());
			pstmt.setString(3, account.getNickname());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			disconnect();
		}
		return true;

	}

	public String checkSign(String id) {
		connect();
		String sql = "SELECT * FROM account WHERE id=?";
		String ID = null;

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			ResultSet rs = pstmt.executeQuery();

			rs.next();
			ID = rs.getString("id");
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			disconnect();
		}
		return ID;
	}

	public PoillY_Account doLogin(String id) {
		connect();
		PoillY_Account account = new PoillY_Account();

		String sql = "SELECT * FROM account WHERE id=?";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			ResultSet rs = pstmt.executeQuery();

			rs.next();

			account.setID(rs.getString("id"));
			account.setPassword(rs.getString("password"));
			account.setAdmin(rs.getInt("admin"));
			account.setNickname(rs.getString("nickname"));
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
			account = null;
		} finally {
			disconnect();
		}
		return account;
	}
	public int getCount(String movie) {
		connect();
		String sql = "SELECT COUNT(*) FROM post where movie =?";
		int value = 0;
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, movie);
			ResultSet rs = pstmt.executeQuery();
			rs.next();
			value = rs.getInt("COUNT(*)");
			rs.close();
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			disconnect();
		}return value;
	}
}
