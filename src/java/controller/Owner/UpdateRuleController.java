/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller.Owner;

import dao.RuleDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import model.Rule;

@WebServlet(name = "UpdateRuleController", urlPatterns = {"/updateRule"})
public class UpdateRuleController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String raw_id = req.getParameter("id");
        int id = Integer.parseInt(raw_id);
        RuleDAO dbRule = new RuleDAO();
        Rule rule = dbRule.findById(id);

        req.setAttribute("rule", rule);
        req.getRequestDispatcher("Owner/update-rule.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String raw_id = req.getParameter("id");
        int id = Integer.parseInt(raw_id);
        RuleDAO dbRule = new RuleDAO();
        Rule rule = dbRule.findById(id);

        String ruleName = req.getParameter("ruleName");
        String img = req.getParameter("img");
        String score = req.getParameter("score");
        String penMoney = req.getParameter("penMoney");

        if (ruleName == null || ruleName.trim().isEmpty() ||
            img == null || img.trim().isEmpty() ||
            score == null || score.trim().isEmpty() ||
            penMoney == null || penMoney.trim().isEmpty()) {

            req.setAttribute("rule", rule);
            req.setAttribute("error", "Vui lòng không bỏ trống hoặc chỉ nhập dấu cách vào các trường.");
            req.getRequestDispatcher("Owner/update-rule.jsp").forward(req, resp);
            return;
        }

        try {
            rule.setRuleName(ruleName.trim());
            rule.setImg(img.trim());

            int parsedScore = Integer.parseInt(score.trim());
            double parsedPenMoney = Double.parseDouble(penMoney.trim());

            if (parsedPenMoney < 0) {
                req.setAttribute("rule", rule);
                req.setAttribute("error", "Tiền phạt không được là số âm.");
                req.getRequestDispatcher("Owner/update-rule.jsp").forward(req, resp);
                return;
            }

            rule.setScoreChange(parsedScore);
            rule.setPenMoney(parsedPenMoney);

            dbRule.update(rule);
            resp.sendRedirect("ruleList");

        } catch (NumberFormatException e) {
            req.setAttribute("rule", rule);
            req.setAttribute("error", "Giá trị điểm hoặc tiền phạt không hợp lệ. Vui lòng nhập đúng định dạng số.");
            req.getRequestDispatcher("Owner/update-rule.jsp").forward(req, resp);
        }
    }
}