/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package eventaw.servlet;

import eventaw.dao.UsuarioFacade;
import eventaw.dao.UsuarioeventoFacade;
import eventaw.entity.Usuario;
import eventaw.entity.Usuarioevento;
import java.io.IOException;
import java.text.SimpleDateFormat;
import javax.ejb.EJB;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Pepe
 */
@WebServlet(name = "ServletGuardarUsuarioEvento", urlPatterns = {"/ServletGuardarUsuarioEvento"})
public class ServletGuardarUsuarioEvento extends HttpServlet {

    @EJB
    private UsuarioeventoFacade usuarioeventoFacade;

    @EJB
    private UsuarioFacade usuarioFacade;

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Usuario usuario = (Usuario) session.getAttribute("user");
        Usuario u;
        String nombre = request.getParameter("nombre");
        String ape1 = request.getParameter("ape1");
        String ape2 = request.getParameter("ape2");
        String domicilio = request.getParameter("domicilio");
        String ciudad = request.getParameter("ciudad");
        String fNac = request.getParameter("fNac");
        String sexo = request.getParameter("sexo");
        String email = request.getParameter("email");
        String contrasena = request.getParameter("pass1");
        String repcontrasena = request.getParameter("pass2");
        String errorEditar = "";
        Boolean correoExiste = false;
        Boolean ContrasenaAnterior = false;
        
         
         if(email!= null && !email.isEmpty()){
            u = this.usuarioFacade.findByEmail(email);
            if(u != null && !u.getCorreo().equals(usuario.getCorreo())){
                correoExiste =true;
            }
         }
            
        if (correoExiste) {
                errorEditar = "Este correo ya ha sido registrado, por favor pruebe con otro.";
                
        }else{ //Si no hay errores hacemos esto.
            if(!contrasena.equals("") && !repcontrasena.equals("")){
                
                if(contrasena.equals(usuario.getContrasenya()) && contrasena.length()!=0){
                    ContrasenaAnterior = true;
                }
                
                if (!(contrasena.equals(repcontrasena))){ // Contraseñas distintas.
                    errorEditar = "Las contraseñas deben ser iguales.";
                   
                }else if(ContrasenaAnterior) {
            
                    errorEditar = "Es la misma contraseña que tenias antes, por favor crea una nueva.";
        
                } else {
                    try{
                        Usuarioevento uEvento = usuario.getUsuarioevento();
                        usuario.setCorreo(email);
                        usuario.setContrasenya(contrasena);
                        uEvento.setApellido1(ape1);
                        uEvento.setApellido2(ape2);
                        uEvento.setCiudad(ciudad);
                        uEvento.setDomicilio(domicilio);
                        uEvento.setFechanacimiento(new SimpleDateFormat("yyyy-MM-dd").parse(fNac));
                        uEvento.setNombre(nombre);
                        uEvento.setSexo(sexo);
                
                        this.usuarioFacade.edit(usuario);
                        this.usuarioeventoFacade.edit(uEvento);
                
                        session.setAttribute("user", usuario);
                    } catch (Exception e){
                        errorEditar = "Error en la fecha: " + e.getMessage();
                    }
                }
                
            } else if(contrasena.equals("") && repcontrasena.equals("")) {
                try{
                    Usuarioevento uEvento = usuario.getUsuarioevento();
                    usuario.setCorreo(email);
                    uEvento.setApellido1(ape1);
                    uEvento.setApellido2(ape2);
                    uEvento.setCiudad(ciudad);
                    uEvento.setDomicilio(domicilio);
                    uEvento.setFechanacimiento(new SimpleDateFormat("yyyy-MM-dd").parse(fNac));
                    uEvento.setNombre(nombre);
                    uEvento.setSexo(sexo);
                
                    this.usuarioFacade.edit(usuario);
                    this.usuarioeventoFacade.edit(uEvento);
                
                    session.setAttribute("user", usuario);
                } catch (Exception e){
                    errorEditar = "Error en la fecha: " + e.getMessage();
                }
            } else {
                errorEditar = "Introduce ambas contraseñas";
            }
        }
        

        request.setAttribute("errorEditar", errorEditar);
        RequestDispatcher rd = request.getRequestDispatcher("perfilUsuario.jsp");
        rd.forward(request, response);
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
