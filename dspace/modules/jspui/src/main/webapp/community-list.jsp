<%--

    The contents of this file are subject to the license and copyright
    detailed in the LICENSE and NOTICE files at the root of the source
    tree and available online at

    http://www.dspace.org/license/

--%>

<%--
  - Display hierarchical list of communities and collections
  -
  - Attributes to be passed in:
  -    communities         - array of communities
  -    collections.map  - Map where a keys is a community IDs (Integers) and 
  -                      the value is the array of collections in that community
  -    subcommunities.map  - Map where a keys is a community IDs (Integers) and 
  -                      the value is the array of subcommunities in that community
  -    admin_button - Boolean, show admin 'Create Top-Level Community' button
  --%>

<%@page import="org.dspace.content.Bitstream"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@ page contentType="text/html;charset=UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@ page
	import="org.dspace.app.webui.servlet.admin.EditCommunitiesServlet"%>
<%@ page import="org.dspace.app.webui.util.UIUtil"%>
<%@ page import="org.dspace.browse.ItemCountException"%>
<%@ page import="org.dspace.browse.ItemCounter"%>
<%@ page import="org.dspace.content.Collection"%>
<%@ page import="org.dspace.content.Community"%>
<%@ page import="org.dspace.core.ConfigurationManager"%>
<%@ page import="javax.servlet.jsp.jstl.fmt.LocaleSupport"%>
<%@ page import="java.io.IOException"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="java.util.Map"%>

<%@ taglib uri="http://www.dspace.org/dspace-tags.tld" prefix="dspace"%>

<%
	Boolean admin_b = (Boolean) request.getAttribute("admin_button");
	boolean admin_button = (admin_b == null ? false : admin_b
			.booleanValue());
%>


<dspace:layout titlekey="jsp.community-list.title">

	<%
		if (admin_button) {
	%>
	<dspace:sidebar>
		<div class="panel panel-warning">
			<div class="panel-heading">
				<fmt:message key="jsp.admintools" />
				<span class="pull-right"> <dspace:popup
						page="<%=LocaleSupport.getLocalizedMessage(
									pageContext,\"help.site-admin\")%>">
						<fmt:message key="jsp.adminhelp" />
					</dspace:popup>
				</span>
			</div>
			<div class="panel-body">
				<form method="post"
					action="<%=request.getContextPath()%>/dspace-admin/edit-communities">
					<input type="hidden" name="action"
						value="<%=EditCommunitiesServlet.START_CREATE_COMMUNITY%>" /> <input
						class="btn btn-default" type="submit" name="submit"
						value="<fmt:message key="jsp.community-list.create.button"/>" />
				</form>
			</div>
	</dspace:sidebar>
	<%
		}
	%>
	
	<div style="display: none;">
		<input type="hidden" id="contextPath" value="<%= request.getContextPath() %>"/>
		<!-- Loader de imagens -->
		<img alt="" src="<%= request.getContextPath() %>/image/deposita_centroeste.png">
		<img alt="" src="<%= request.getContextPath() %>/image/deposita_nordeste.png">
		<img alt="" src="<%= request.getContextPath() %>/image/deposita_norte.png">
		<img alt="" src="<%= request.getContextPath() %>/image/deposita_sudeste.png">
		<img alt="" src="<%= request.getContextPath() %>/image/deposita_sul.png">
	</div>
	
	<h1>
		<fmt:message key="jsp.community-list.title" />
	</h1>
	<p>
		<fmt:message key="jsp.community-list.text1" />
	</p>

	<div class="col-md-12 text-center">

		<img id="mapa-brasil" src="<%=request.getContextPath()%>/image/colecoes_deposita.png"
			usemap="#mapa-brasil" />

		<map name="mapa-brasil">
			<area shape="poly" regiao="sul"
				coords="309,442,362,442,365,444,366,449,366,457,367,462,371,464,376,465,384,465,387,467,389,472,389,520,388,522,385,525,381,525,372,526,368,527,366,530,365,535,364,546,360,548,350,549,348,549,346,551,344,552,343,555,343,566,341,568,339,571,338,571,334,572,327,572,325,572,321,576,320,587,319,590,316,593,314,594,310,594,306,592,305,589,304,554,302,550,298,548,263,549,260,546,258,541,259,536,264,534,272,533,279,532,282,528,282,515,285,512,290,510,298,510,302,509,304,506,305,480,304,446,309,442"
				href="<%= request.getContextPath() + "/" + ConfigurationManager.getProperty("handle.regiao.sul") %>" alt="">
			<area shape="poly" regiao="sudeste"
				coords="333,432,368,434,373,437,374,450,376,456,387,456,407,457,410,453,411,442,412,436,417,433,476,433,479,431,480,429,481,414,484,410,499,410,503,407,504,405,504,393,508,386,523,386,526,382,527,377,525,373,519,371,510,371,505,369,504,367,504,330,501,327,498,326,488,325,483,324,481,321,480,306,479,303,472,303,424,303,421,305,420,311,420,316,419,327,420,364,418,369,413,371,356,372,352,375,350,378,351,412,348,416,348,418,340,417,333,418,329,420,327,424,327,427,328,431,333,432"
				href="<%= request.getContextPath() + "/" + ConfigurationManager.getProperty("handle.regiao.sudeste") %>" alt="">
			<area shape="poly" regiao="centroeste"
				coords="190,236,196,233,208,233,212,230,212,214,214,211,224,210,234,207,235,194,235,191,239,189,246,188,250,192,250,201,249,222,250,228,261,234,360,234,365,238,365,245,362,248,356,248,346,249,344,253,343,275,347,279,407,280,412,285,412,359,410,362,409,363,402,364,348,364,343,368,342,404,341,407,339,409,334,410,322,411,320,414,319,427,317,432,286,433,281,429,281,416,278,410,265,410,262,408,259,406,258,348,255,342,250,340,219,341,217,340,213,336,212,254,210,251,202,249,193,247,189,245,190,236"
				href="<%= request.getContextPath() + "/" + ConfigurationManager.getProperty("handle.regiao.centroeste") %>" alt="">
			<area shape="poly" regiao="nordeste"
				coords="527,359,528,277,533,272,547,270,551,251,555,249,571,247,574,229,581,226,592,224,596,222,596,169,593,164,555,163,550,160,550,144,545,141,531,140,528,138,526,121,522,118,440,117,436,113,435,99,431,95,425,95,421,98,419,105,420,117,420,128,419,135,419,138,413,141,401,141,400,144,397,148,397,197,404,201,413,202,417,204,419,209,419,287,420,291,422,294,483,295,489,300,489,310,491,314,495,318,501,318,506,319,511,322,512,356,513,361,520,364,524,363,527,359"
				href="<%= request.getContextPath() + "/" + ConfigurationManager.getProperty("handle.regiao.nordeste") %>" alt="">
			<area shape="poly" regiao="norte"
				coords="107,247,30,249,27,231,9,223,4,212,5,199,5,189,26,187,29,143,37,142,62,142,75,138,74,52,78,50,110,49,113,60,112,67,115,70,128,72,137,71,142,69,143,29,147,27,209,25,212,21,213,8,213,8,217,4,223,3,228,9,227,46,228,67,232,71,245,72,257,70,259,57,260,50,267,48,321,48,328,45,328,32,331,27,339,27,341,28,343,29,344,36,344,43,345,47,362,48,364,51,366,55,366,89,368,93,371,94,407,95,412,99,412,128,408,133,391,133,388,138,389,140,388,205,391,208,396,210,408,211,411,214,412,267,407,272,356,272,352,268,352,263,353,258,359,257,367,255,371,253,374,245,375,231,372,228,368,225,355,225,264,225,258,221,258,215,259,185,253,179,231,180,228,183,228,194,228,197,222,201,209,201,205,207,204,220,202,224,184,225,181,251,186,256,200,257,204,261,204,289,197,295,190,290,188,277,186,273,178,271,148,272,144,268,143,230,139,226,131,225,115,225,112,240,112,246,107,247"
				href="<%= request.getContextPath() + "/" + ConfigurationManager.getProperty("handle.regiao.norte") %>" alt="">
		</map>

	</div>
	
	<script type="text/javascript" src="<%= request.getContextPath() %>/static/js/map-manager.js"></script>

</dspace:layout>
