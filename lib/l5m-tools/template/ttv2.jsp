<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java"
    import="java.util.*,
    com.l5m.common.bean.*, 
    com.l5m.common.l5m_util.bean.*,
    com.l5m.common.l5m_util.rld.*,
    com.l5m.common.util.*,
    org.ajaxanywhere.AAUtils,
    com.l5m.ttv2.bean.*, 
    com.l5m.ttv2.engine.worker.*,
    com.l5m.common.l5m_util.module.*"
 %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://ajaxanywhere.sourceforge.net/" prefix="aa"%>
<%@ taglib uri="http://l5m.com/ui" prefix="l5m"%>
<%@ taglib uri="http://l5m.com/ajax" prefix="l5mAjax"%>
<%@ taglib uri="http://l5m.com/util" prefix="l5mU"%>
<%@ taglib uri="http://l5m.com/functions" prefix="l5mfunctions"%>
<%@ taglib uri="http://l5m.com/mod" prefix="mod"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="f"%>


<c:set value="${requestScope.RequestWorker}" var="worker" />
<c:set value="${worker.servicer}" var="servicer" /> 
<c:set value="${servicer.baseServicerParameterBean}" var="baseServicerParameterBean" /> 
<c:set value="${baseServicerParameterBean}" var="paraBean" /> 
<c:set var="formName" value="${worker.FORM_NAME}" scope="request"/> 
<c:set var="packageLowerCase" value="${worker.packageLowerCase}" scope="request"/>
<c:set var="packageUpperCase" value="${worker.packageUpperCase}" scope="request"/>
<c:set var="styleLowerCase" value="${packageLowerCase}" />
<c:set var="styleUpperCase" value="${packageUpperCase}" />
<c:set var="PANEL" value="${worker.PANEL}"/>
<%
if(AAUtils.isAjaxRequest(request)){
    AAUtils.addZonesToRefresh(request, "alwaysRefreshZone,"+ ((String)request.getAttribute("refreshZones"))); 
}  
%> 


<html>
    
    


    <l5m:jspHead useIE7Compatible="true"  title="${worker.APP_NAME}" formName="${formName}" packageName="${packageLowerCase}" planingCss="L001;L004">
        
        <!-- add additinal js css in here -->
        
        <link href="<%=request.getContextPath()%>/htdoc/datepicker-lite.css" rel="stylesheet" type="text/css" />
        <script type="text/javascript" src="<%=request.getContextPath()%>/tagresources/javascript/timeSpan/datepicker-lite.js "></script> 
   
        <script type="text/javascript" src='<%=request.getContextPath()%>/tagresources/javascript/TopBar2.js'></script> 
        <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/tagresources/css/TopBar2/TopBar2.css" /> 
           
        
        <!--  addtion javascript here -->
        <%@ include file="CommonVariables.jsp"%> 
        <c:set var="colors" value="<%=colors%>" scope="request"/> 
                
        <style>            
            body{
                background-color: #FFFFFF;
                margin-top: 0px;
                margin-bottom: 0px;
                margin-left: 0px;
                margin-right: 0px;
            }

            td.single_line_control{
                white-space: nowrap;
                vertical-align: middle;
            }
            
            td.even_row{
                background-color: #FFFFFF;
            }
            
            td.odd_row{                
                background-color: #E7E3E7;
            }
            
            td.highlighted{
                background-color: #FFFF66;
            }
            
            td.odd_row, td.even_row, td.highlighted{
                vertical-align: top;
                color: #000000;
                border-color: #CCCCCC #CCCCCC;
                border-style: solid; 
                border-top-width: 0px; 
                border-right-width: 1px; 
                border-bottom-width: 1px; 
                border-left-width: 0px;
            }
            
            span.field_label{
                padding-left: 5px;
                padding-right: 5px;
                font-weight: bold;
            }
            
            span.action_link{
                padding-left: 5px;
                padding-right: 5px;
            }
            
            a.action_link{
                font-weight: bold;
            }
            
            a.action_link:link {color: #0000FF; text-decoration: none}
            a.action_link:visited {color: #0000FF; text-decoration: none}
            a.action_link:hover {color: #FF0000; text-decoration: none}
            
            table.section{
                left: 0px;
                width: 100%;
                border-style: solid;
                border-color: #00AF8A;
                border-width: 1px;
            }
            
            td.table_header{
                background-color: #FFFFFF;
                text-align: center;
                font-weight: bold;
                border-color: #CCCCCC;
                border-style: solid; 
                border-top-width: 1px; 
                border-right-width: 1px; 
                border-bottom-width: 1px; 
                border-left-width: 1px;
            }
            
            td.left_border{
                border-color: #CCCCCC;
                border-style: solid; 
                border-top-width: 0px; 
                border-right-width: 0px; 
                border-bottom-width: 0px; 
                border-left-width: 1px;
            }
            span.header_text, span.media_type_header, span.media_type_option{
                font-weight: bold;
            }
            
            span.media_type_header{
                padding-left: 5px;
                padding-right: 20px;
            }
            
            span.single_line{
                white-space: nowrap;
            }
            
            select.add_remove{
                width: 100%;
            }
            
            #tab_{
                white-space: nowrap;
                vertical-align: middle;
                height: 20px;
                width: 1%;
                background-color: #FFE88A;
            }
            
            #tab_spacer{
                height: 20px;
                border-bottom-style: solid;
                border-bottom-width: 1px;
                border-bottom-color: #00AF8A;
            }
            
            #static_control_spacer, #tab_spacer{
                white-space: nowrap;
                height: 20px;
                width: 95%;
            }
            
            span.tab_label{
                font-weight: bold;
                padding: 5px;
            }
            
            .trans_off{
                border: 1px;
                border-style: solid;
                border-color: black;
                background-color: #FFE88A;
                border-color: #CCCCCC;
                padding: 2px;
                height: 20px;
            }
            
            .trans_on{
                border: 1px;
                border-style: solid;
                border-color: black;
                background-color: #FFE88A;
                opacity:.50;
                filter: alpha(opacity=50); 
                -moz-opacity: 0.5;
                border-color: #CCCCCC;
                padding: 2px;
                height: 20px;
            }
            
            .bucket_border{
                background-color: #FFFFFF; 
                color: #000000; 
                border-color: #00AF8A;
                border-style: solid; 
                border-top-width: 0px; 
                border-right-width: 1px; 
                border-bottom-width: 1px; 
                border-left-width: 1px;
            }

            .tab_border{    
                background-color: #FFFFFF; 
                color: #000000; 
                border-color: #00AF8A;
                border-style: solid; 
                border-top-width: 1px; 
                border-right-width: 1px; 
                border-bottom-width: 0px; 
                border-left-width: 1px;
                padding: 2px;
            }
            
            .bottom_border{
                background-color: #FFFFFF; 
                color: #000000; 
                border-color: #00AF8A;
                border-style: solid; 
                border-top-width: 0px; 
                border-right-width: 0px; 
                border-bottom-width: 1px;
                border-left-width: 0px; 
                padding: 0px;
            }
            
            .tab_unselected{
                border-color: #00AF8A;
                border-style: solid; 
                border-top-width: 1px; 
                border-right-width: 1px; 
                border-bottom-width: 1px; 
                border-left-width: 1px;
                padding: 2px;
            }
            img{
                border:none;
            }
            
            *{
                font-size:11px;
            }
            
            .Q_SubmitBox{
                height: auto;
                margin: 4px;
                margin-top: 0px;
                padding: 1px 4px;
                padding-top: 0px;
                background-color: #ddeeff;
                border: 1px solid #77aacc;
                border-top-style: none;
            }
            
            
        </style>
         

                

    
        <script type="text/javascript"><!--
            ajaxAnywhere.formName = "${worker.FORM_NAME}";   
            var QHTAjaxObject = new QHTAjaxUtil('<%=request.getContextPath()%>/servlet/L5MOnline/<%=AppConfig.getProperty("appL5MOnline")%>','${worker.url}','<%=AppConfig.getProperty("butOption")%>'); 
            var pageAction = new PageAction(window, "${worker.FORM_NAME}", "<%=AppConfig.getProperty("butOption")%>", "panelIndex" , "displayStage" , '<%=request.getContextPath()%>/servlet/L5MOnline?work=ForwardToJspWorker&jsp=IntermediaRefreshN2&irStatus=firstTime&showLocalForm=N')

            AjaxAnywhere.prototype.getGlobalScriptsDeclarationsList = function(script) {
                return ["paginatorDetail_pageChanged"];
            }    
            function ts_notify_time_changed(){  
                    pageAction.changeTime();  
            }
            function hideDialog(dId){
                pageAction.hideDialog(dId);
            }
            function showDialog(dId){ 
                pageAction.showDialog(dId);
            }
            function clickButton(button){
                pageAction.clickButton(button);
            } 
            function navDesc_ShowStepInfo(s){
            }
        //-->            
         </script> 
        <style> 
            #sourcePanel td{ /* all tds in sourcePanel will be nowrap.*/
                white-space:nowrap;
            }
        </style> 
        
        
 
    
        
        
    </l5m:jspHead> 
    
    <body bgcolor="#ffffff" marginwidth="0" marginheight="0" leftmargin="0" topmargin="0">
        <div id="mainmessage" align="center">
             <span style="font-family: Arial, Helvetica, sans-serif; font-size: 16px; font-weight: bold">
                 <br/>
                 <br/>
                 <br/>
                 <br/>
                 Please wait ...<br />
             </span>
        </div>
        <div id="mainpart" style="display: none;">
            <form class="formnomargin" name="${worker.FORM_NAME}" id="${worker.FORM_NAME}" action="<%=AppConfig.getProperty("appL5MOnline")%>" method="post">
                <input type="hidden" name="<%=AppConfig.getProperty("requestAction")%>"  id="<%=AppConfig.getProperty("requestAction")%>"  value="${worker.WORKER_NAME}" />
                <input type="hidden" name="<%=AppConfig.getProperty("srcPage")%>" id="<%=AppConfig.getProperty("srcPage")%>" value="${worker.jspGoto}" />
                <input type="hidden" name="<%=AppConfig.getProperty("butOption")%>" id="<%=AppConfig.getProperty("butOption")%>"  value="" /> 
                <input type="hidden" name="1stnavbar" id="1stnavbar" value="<%=request.getParameter("1stnavbar")%>" /> 
                <input type="hidden" name="2ndnavbar"  id="2ndnavbar" value="<%=request.getParameter("2ndnavbar")%>" /> 
                <input type="hidden" name="<%=SessionConstants.NAV_COMPANY_ID%>" id="<%=SessionConstants.NAV_COMPANY_ID%>" value="${worker.servicer.companyId}" /> 
                <input type="hidden" name="<%=TTVConstants.MODULE_INDEX%>" id="<%=TTVConstants.MODULE_INDEX%>" value="" />  
                  <aa:zone name="alwaysRefreshZone"> 
                    <input type="hidden" name="panelIndex" id="name" value="${paraBean.panelIndex}"/> 
                    <input type="hidden" name="displayStage" id="displayStage" value="${paraBean.displayStage}"/>  
                    <c:set var="onchange" value=""/>
                    <c:if test="${paraBean.displayStage}">
                        <c:set var="onchange">pageAction.clearResult(); </c:set>
                    </c:if>  
                </aa:zone>
               
             
               
                <aa:zone name="topNavigationZone"> 
                     <l5m:TopBar2
                            id="TopBar" 
                             topBarIcons = "${worker.topBarIcons}"
                             iconsStatus = "${worker.iconsStatus}"
                             actions = "${worker.actions}"
                             decimalControlList = "${servicer.reportDecimalControlList}"
                             startControlZone = "topPanel"
                             style = "${styleLowerCase}"
                             incValueMap = "${paraBean.SORT_DISPLAY_MAP}"
                             incSelectedSet = "${paraBean.selectedDisplayBy}"
                             incSingleSelected = "${paraBean.selectedSortBy}"
                         /> 
                </aa:zone>
                
                <div id="topPanel" style="display:${paraBean.selectionPanelStatusOpen?'inline':'none'}" >
                <!--source panel begin-->
                    <div id="accordionNavigationTab">
                        <table  border="0" cellspacing="0" cellpadding="0" width="100%">
                            <tr>
                                <td> 
                                    
                                        <l5m:tabPanel2
                                        id="accordionTestTop" 
                                        captions="${baseServicerParameterBean.tabbedPanelCaptions}" 
                                        selected="${baseServicerParameterBean.selectedTab}" 
                                        style="${styleLowerCase}"
                                        showDisplayControl="false"> 
                                        <l5m:tab2>
                                            <div class="text">  
                                                <table border="0" cellspacing="0" cellpadding="0" width="100%"    style='height:100%;font-size:11px;'>  
                                                    <tr>
                                                      <td style="padding-left:3px;padding-right:5px; " valign="top" height="170px;" >  
                                                          
                                                               <table  border="0" cellspacing="0" cellpadding="0" width="100%">
                                                                  <tr>
                                                                    <td  style=' ' style='width:50%;' nowrap="nowrap" valign="top" > 
                                                                      <c:set var="timeSpanController" scope="request" value="${baseServicerParameterBean.timeSpanController}"/>
                                                                      <jsp:include page="TimeSpanNew.jsp" flush="true">
                                                                            <jsp:param name="formName" value="${worker.FORM_NAME}" />
                                                                            <jsp:param name="notifyOnChange" value="Y" />
                                                                            <jsp:param name="timeSpanIndex" value="0" />
                                                                       </jsp:include>  
                                                                    </td>  
                                                                </tr>  
                                                            </table>

                                                          <aa:zone name="sourcePanelZone"> 
                                                            <table id='sourcePanel' border="0" cellspacing="0" cellpadding="0" width="100%">
                                                                 <tr><td></td></tr>
                                                            </table> 
                                                          </aa:zone>    
                                                       </td>
                                                    </tr> 
                                                </table>     
                                            </div> 
                                        </l5m:tab2>  
                                        

                                        
                                        
                                     </l5m:tabPanel2> 
                                </td>
                            </tr>
                        </table>  
                    </div> 
                    <!--source panel end-->
                    <div class="Q_SubmitBox">
                      <table cellspacing="0" cellpadding="0" width="100%" style="margin-left:4px;margin-right:0px; ">
                                <tr>
                                    <td   colspan="100%" >
                                        <table width="100%" cellpadding="0" cellspacing="0">
                                            <tr  bgcolor='#DDEEFF'>
                                                <td nowrap="nowrap" width="25%" style="text-align:left" >&nbsp;</td>
                                                <td nowrap="nowrap" width="50%" style="text-align:center"  >
                                                    <b> <a href="javascript:pageAction.submit()"><img   style='border:none' src="/ttv2/image/gif/submitBut.gif"/></a></b>
                                                </td>
                                                <td nowrap="nowrap" width="25%" style="text-align:right"  >&nbsp;</td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                        </table>
                    </div>
                    
                    
                </div>
                <!-- the end -->
                             
                <!--report panel start-->
                <!--report panel start-->
                <div class="Q_reportBox" >
                    
                    
                    <table border="0" cellpadding="0" cellspacing="0" width="100%" style="margin-left:2px; margin-top:5px" class="reportTable">
                        <tr>
                            <td align="left" valign="top" width="99%">
                                <aa:zone name="result">
                                    <input type="hidden" name="panelIndex" id="name" value="${baseServicerParameterBean.panelIndex}"/> 
                                    <input type="hidden" name="displayStage" id="displayStage" value="${worker.servicer.displayStage}"/> 
                                    <c:set var="PANEL" value="${worker.PANEL}"/>
                                    <table id="sectable" border="0" cellpadding="0" cellspacing="0" width="100%" height="26"> 
                                        <tbody>
                                             <tr align="center">
                                                 <c:forEach items="${PANEL}" var="panel" varStatus="panelIndex">
                                                    <c:if test="${panel.enable}">
                                                        <c:set var="jsChangePanel">
                                                            javascript:pageAction.changePanel('${panelIndex.index}');
                                                        </c:set> 
                                                        <c:if test="${panelIndex.index ==worker.dataAvailability || panelIndex.index ==worker.help}">
                                                            <td   width="120px"  style=' ${worker.servicer.panelIndex == panelIndex.index ?"cursor: none" : ""} ; white-space:nowrap; ${ true ?"font-weight: bold" : ""} ; font-size:11px; border-top-width:0px;${panelIndex.first?"border-left-width:0px":""}'  nowrap id="displayBy_${panelIndex.index }" onclick="${baseServicerParameterBean.panelIndex== panelIndex.index ? '':(true? jsChangePanel:'')}" class="${worker.servicer.panelIndex== panelIndex.index? 'sec2' : true ?'sec1':'sec1'}" >
                                                                ${panel.label}  
                                                            </td >  
                                                        </c:if>
                                                        <c:if test="${!(panelIndex.index ==worker.dataAvailability || panelIndex.index ==worker.help)}">
                                                            <td   width="145px"  style=' ${worker.servicer.panelIndex == panelIndex.index || !worker.servicer.displayStage ?"cursor: none" : ""} ; white-space:nowrap; ${worker.servicer.panelIndex == panelIndex.index || worker.servicer.displayStage ?"font-weight: bold" : ""} ; font-size:11px; border-top-width:0px;${panelIndex.first?"border-left-width:0px":""}'  nowrap id="displayBy_${panelIndex.index }" onclick="${baseServicerParameterBean.panelIndex== panelIndex.index ? '':(worker.servicer.displayStage? jsChangePanel:'')}" class="${worker.servicer.panelIndex== panelIndex.index? 'sec2' :worker.servicer.displayStage?'sec1':'sec1'}" >
                                                                ${panel.label }  
                                                            </td >   
                                                        </c:if>
                                                    </c:if> 
                                                </c:forEach>   
                                                <td class="sec1" style="border-color:#63B1e6; border-top-width:0px;  border-right-width:0px;cursor: none;">&nbsp;</td>
                                            </tr>
                                        </tbody>
                                    </table>
                                    
                                
                                   <br/>  
                                   <div style='clear:both'/>
                                   
                                       <table width="100%">
                                        <tr> 
                                        <td  nowrap="nowrap"  height="40px" style="padding-left:5px;" >     
                                        </td>
                                        
                                        <td  nowrap="nowrap"  height="40px" style="text-align:right;">         
                                            <c:if test="${baseServicerParameterBean.panelIndex !=worker.help && baseServicerParameterBean.panelIndex !=worker.dataAvailability}" > 
                                                 ${worker.renderPaginatorHTML} 
                                           </c:if> 
                                         </td>
                                        </tr>
                                    </table> 
                                   
                                    
                                        <table border="0" cellpadding="0" cellspacing="0" width="100%" >
                                        <tr>  <td  nowrap="nowrap" align='left' >    
                                              <c:if test="${baseServicerParameterBean.panelIndex !=worker.help && baseServicerParameterBean.panelIndex !=worker.dataAvailability}" > 
                                             <!--    <a style='font-weight:bold' href='javascript:pageAction.clickExportButton("exportToCSV")'>[Export to CSV] </a> <br/><br/> -->
                                              </c:if>
                                         </td></tr>
                                        <tr>  

                                        <td  nowrap="nowrap" align='center' >    
                                             <c:if test="${baseServicerParameterBean.panelIndex !=worker.help && baseServicerParameterBean.panelIndex !=worker.dataAvailability}" > 
                                                ${worker.renderHTML}      
                                             </c:if>  
                                         </td>
                                        </tr>
                                    </table> 
                                       
                                        
                                        
                                 
                                   
                                   
                                   
                                   <c:if test="${baseServicerParameterBean.panelIndex ==worker.help}">
                                        <!-- the div of descriptionTab -->
                                        <div id="descriptionTab"><br/><br/><l5m:appDesc
                                            navigationBean="${worker.navigationBean}" style="ttv2" id="navDesc" />
                                        </div>
                                        <!-- the end descriptionTab--> 
                                    </c:if>
                                    
                                    <c:if test="${baseServicerParameterBean.panelIndex ==worker.dataAvailability}">
                                        <table width="100%">
                                            <tr>
                                            <td width="15%" rowspan="4">&nbsp;</td>
                                            <td width="70%">
                                                <c:set var="moduleGeneralAvailability" scope="request" value="${worker.servicer.generalAvailabilityModule}"/>
                                                <!--  GeneralAvailabilityModule.SESSION_NAME -->
                                                <table border="0" cellpadding="0" cellspacing="2" width="100%"> 
                                                    <jsp:include page="GeneralAvailabilityModule.jsp" flush="true"/>
                                                </table>
                                            </td>
                                            <td width="15%" rowspan="4">&nbsp;</td>
                                            </tr>
                                            </table> 
                                    
                                    </c:if> 
                                </aa:zone> 
                            </td>
                        </tr>
                    </table>     
                </div>
                <!--report panel end-->
                 
                <!--  dialog -->
                
                          
                <l5m:dialog
                        id="sortDialog"
                        title="sort"
                        overlayZIndex="100"
                        dialogWidth="500px"
                        dialogLeft="200"
                        style="${styleLowerCase}"
                        >
                       <aa:zone name="sortDialogZone"> 
                        <table style="font-size:11px;">
                            <tr> 
                             <td id="sortingTD" style="text-align:left;white-space:nowrap;"> 
                                    <c:if test="${!empty worker.servicer.sortingKeysModuleStateBean}">                       
                                        <l5m:sortingKeysModule2 style="${styleLowerCase}"   moduleTitle="Sort By"       sortingKeysModuleStateBean="${worker.servicer.sortingKeysModuleStateBean}"  id="${worker.servicer.sortingKeysModuleStateBean.id}"/>
                                    </c:if>
                              </td>
                            </tr>
                            
                        </table>
                       
                       
                          <script language="javascript1.2" type="text/javascript">
                            <c:if test="${worker.showDialog}"> 
                                $('sortDialog').show();
                            </c:if>
                          </script>
                      
                        </aa:zone>
                            <l5m:dialogBottom> 
                                      <a href="javascript:pageAction.clickButton('<%=ActionConstants.SORT_RERESH%>');;pageAction.hideDialog('sortDialog')">  [OK]</a>
                                      <a href="javascript:pageAction.hideDialog('sortDialog');">[Cancel]</a>
                                       <a href="javascript:pageAction.clickButton('<%=ActionConstants.SORT_RERESH%>');">[Apply]</a>
                            </l5m:dialogBottom>
                </l5m:dialog>
                
                 <l5m:dialog
                        id="displayDialog"
                        title="Columns & Rows"
                        overlayZIndex="100"
                        dialogWidth="500px"
                        dialogHeight="300px"
                        canClose="true"
                        style="${styleLowerCase}"> 
                        <aa:zone name="displayDialogZone"> 
                          
                                <table>
                                    <tr>
                                    <td style="text-align:left;white-space:nowrap;" valign="top">  
                                        <c:if test="${!empty worker.servicer.columnsMap}">
                                          <l5m:multipleSelect
                                                 id="multipleColumnsController"
                                                 style="${styleLowerCase}"
                                                 title="<b>Columns</b>"
                                                 sourceValues="${worker.servicer.columnsMap}"
                                                 selectedValues="${worker.servicer.selectedColumns }"
                                                 onChange=""
                                                 displayMode="2"
                                                 useSortBy="true"
                                                 sortBy="1"
                                                 sortField="2"
                                                 selectedLabel="Select"
                                                 sourceLabel="Source"
                                                 sourceWidth="200"
                                                 destinationWidth="200"
                                                 sourceSize="5"
                                                 destinationSize="5"
                                            /> 
                                        </c:if>   
                                 </td>
                                 </tr> 
                                </table>
                             
                        <script  type="text/javascript">
                            <c:if test="${worker.showDialog}">     
                                $('displayDialog').show();
                            </c:if>
                        </script>                   
                     </aa:zone>
                    <l5m:dialogBottom>
                        <a href="javascript:pageAction.hideDialog('displayDialog');pageAction.clickButton('<%=ActionConstants.DISPLAY_REFRESH%>');">[OK]</a>
                            &nbsp;&nbsp;
                        <a href="javascript:pageAction.hideDialog('displayDialog');">[Cancel]</a>
                            &nbsp;&nbsp;
                        <a href="javascript:pageAction.clickButton('<%=ActionConstants.DISPLAY_REFRESH%>');">[Apply]</a>
                    </l5m:dialogBottom>
                </l5m:dialog>


                 <l5m:dialog
                        id="filterDialog"
                        title="Filter"
                        overlayZIndex="100"
                        dialogWidth="700px"
                        dialogHeight="300px"
                        canClose="true"
                        style="${styleLowerCase}"> 
                        <aa:zone name="filterDialogZone">   
                            <script  type="text/javascript">
                                <c:if test="${worker.showDialog}">     
                                    $('filterDialog').show();
                                </c:if>
                            </script>                   
                        </aa:zone>
                    <l5m:dialogBottom>
                        <a href="javascript:pageAction.hideDialog('filterDialog');pageAction.clickButton('<%=ActionConstants.FILTER_REFRESH%>');">[OK]</a>
                            &nbsp;&nbsp;
                        <a href="javascript:pageAction.hideDialog('filterDialog');">[Cancel]</a>
                            &nbsp;&nbsp;
                        <a href="javascript:pageAction.clickButton('<%=ActionConstants.FILTER_REFRESH%>');">[Apply]</a>
                    </l5m:dialogBottom>
                </l5m:dialog>
    
            
         
            
                
         
                <!-- end dialog -->
                 
            </form>
            
         <script type="text/javascript"  src='<%=request.getContextPath()%>/tagresources/javascript/QHTInputUtil.js'></script>
         <script type="text/javascript">
            function m_clickButton2(button, index){
                document.${worker.FORM_NAME}.<%=AppConfig.getProperty("butOption")%>.value = button;
                document.${worker.FORM_NAME}.<%=TTVConstants.MODULE_INDEX%>.value = index; 
                document.${worker.FORM_NAME}.submit();
            }    
            document.getElementById('mainmessage').style.display='none';
            document.getElementById('mainpart').style.display='inline';
        </script>     
        </div>
    </body> 
</html>
  
         
