package poilly;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.util.*;
import java.io.*;
import com.oreilly.servlet.*;
import com.oreilly.servlet.multipart.*;
import java.text.SimpleDateFormat;

/**
 * Servlet implementation class Servlet
 */
@WebServlet(description = "PoillY 서블릿", urlPatterns = { "/Servlet" })
public class Servlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Servlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");

		HttpSession session = request.getSession();
		Beans gb = new Beans();
		PoillY_Movie movie = new PoillY_Movie();
		PoillY_Post post = new PoillY_Post();
		PoillY_Account account = new PoillY_Account();
		PoillY_Account account2 = new PoillY_Account();

		String action = request.getParameter("action");
		try {
			if (action == null) {
				action = "movie_insert";
			}
			if (action.equals("movie_list")) {
				ArrayList<PoillY_Movie> movie_datas = gb.getMovieList();
				request.setAttribute("movie_datas", movie_datas);
				request.getRequestDispatcher("movie_list.jsp").forward(request, response);
			} else if (action.equals("post_list")) {
				int pagenum;
				int maxpagenum;
				if (request.getParameter("pagenum") != null) {
					pagenum = Integer.parseInt(request.getParameter("pagenum"));
				} else {
					pagenum = 0;
				}
				maxpagenum = gb.getCount(request.getParameter("movie_title"));
				ArrayList<PoillY_Post> post_datas = gb.getPostList(request.getParameter("movie_title"), pagenum * 10,
						(pagenum + 1) * 10);
				PoillY_Movie movie_data = gb.getMoviebyName(request.getParameter("movie_title"));
				request.setAttribute("pagenum", pagenum);
				request.setAttribute("maxpagenum", maxpagenum);
				request.setAttribute("post_datas", post_datas);
				request.setAttribute("movie_data", movie_data);
				request.getRequestDispatcher("post_list.jsp").forward(request, response);
			} else if (action.equals("movie_insert")) {
				int maxSize = 1024 * 1024 * 10;
				String root = "";
				try {
					root = request.getSession().getServletContext().getRealPath("/");
					String savePath = root + "upload/";
					MultipartRequest multi = new MultipartRequest(request, savePath, maxSize, "UTF-8",
							new DefaultFileRenamePolicy());
					movie.setTitle(multi.getParameter("title"));
					movie.setStory(multi.getParameter("story"));
					String uploadFile = multi.getFilesystemName("image");
					movie.setImage("upload/" + uploadFile);
				} catch (Exception e) {
					e.printStackTrace();
				}
				if (gb.insertMovie(movie)) {
					response.sendRedirect("Servlet?action=movie_list");
				} else {
					throw new Exception(root);
				}
			} else if (action.equals("post_insert")) {
				post.setMovie(request.getParameter("movie"));
				post.setTitle(request.getParameter("title"));
				post.setWriter(request.getParameter("writer"));
				post.setWriter_id(request.getParameter("writer_id"));
				post.setStar(Integer.parseInt(request.getParameter("star-input")));
				post.setSpoiller(Integer.parseInt(request.getParameter("spoiller")));
				post.setContents(request.getParameter("contents"));
				if (gb.insertPost(post)) {
					if (gb.updateMoviestar(post.getMovie())) {
						response.sendRedirect("Servlet?action=movie_list");
					} else {
						throw new Exception("DB star 업데이트 오류");
					}
				} else {
					throw new Exception("DB 입력 오류");
				}
			} else if (action.equals("contents")) {
				PoillY_Post post_data = gb.getPost(request.getParameter("id"));
				PoillY_Movie movie_data = gb.getMoviebyName(post_data.getMovie());
				post_data.setView(post_data.getView() + 1);
				gb.updatePost(post_data);
				request.setAttribute("post_data", post_data);
				request.setAttribute("movie_data", movie_data);
				request.getRequestDispatcher("post.jsp").forward(request, response);
			} else if (action.equals("post_edit")) {
				PoillY_Post post_data = gb.getPost(request.getParameter("id"));
				PoillY_Movie movie_data = gb.getMoviebyName(post_data.getMovie());
				request.setAttribute("post_data", post_data);
				request.setAttribute("movie_data", movie_data);
				request.getRequestDispatcher("post_edit_form.jsp").forward(request, response);
			} else if (action.equals("post_update")) {
				post.setId(Integer.parseInt(request.getParameter("id")));
				post.setMovie(request.getParameter("movie"));
				post.setTime(request.getParameter("time"));
				post.setView(Integer.parseInt(request.getParameter("view")));
				post.setTitle(request.getParameter("title"));
				post.setWriter(request.getParameter("writer"));
				post.setStar(Integer.parseInt(request.getParameter("star")));
				post.setSpoiller(Integer.parseInt(request.getParameter("spoiller")));
				post.setContents(request.getParameter("contents"));
				if (gb.updatePost(post)) {
					if (gb.updateMoviestar(post.getMovie())) {
						response.sendRedirect("Servlet?action=movie_list");
					} else {
						throw new Exception("DB star 업데이트 오류");
					}
				} else {
					throw new Exception("DB 입력 오류");
				}

			} else if (action.equals("post_delete")) {
				String num = gb.getPost(request.getParameter("id")).getMovie();
				if (gb.deletePost(request.getParameter("id"))) {
					if (gb.updateMoviestar(num)) {
						response.sendRedirect("Servlet?action=movie_list");
					} else {
						throw new Exception("DB star 업데이트 오류");
					}
				} else {
					throw new Exception("DB 삭제 오류");
				}
			} else if (action.equals("Sign")) {
				account.setID(request.getParameter("ID"));
				account.setPassword(request.getParameter("password"));
				account.setPassword_check(request.getParameter("password_check"));
				account.setNickname(request.getParameter("nickname"));
				if (gb.checkSign(account.getID()) != null) {
					response.sendRedirect("PoillY_Sign.jsp?fail=1");
				} else if (!account.getPassword().equals(account.getPassword_check())) {
					response.sendRedirect("PoillY_Sign.jsp?fail=2");
				} else if (gb.doSign(account)) {
					response.sendRedirect("Servlet?action=movie_list");
				} else {
					throw new Exception("회원가입 실패: DB오류");
				}
			} else if (action.equals("login")) {
				account.setID(request.getParameter("ID"));
				account.setPassword(request.getParameter("password"));
				account2 = gb.doLogin(account.getID());
				if (account2 == null) {
					response.sendRedirect("PoillY_login.jsp?fail=1");
				} else if (account2.getPassword().equals(account.getPassword())) {
					session.setAttribute("account", account2);
					response.sendRedirect("Servlet?action=movie_list");
				}else {
					response.sendRedirect("PoillY_login.jsp?fail=1");
				}
			} else if (action.equals("logout")) {
				session.invalidate();
				response.sendRedirect("Servlet?action=movie_list");
			}
		} catch (Exception e) {
			request.setAttribute("exception", e);
			RequestDispatcher dispatcher = request.getRequestDispatcher("PoillY_error.jsp");

			dispatcher.forward(request, response);
		}

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
