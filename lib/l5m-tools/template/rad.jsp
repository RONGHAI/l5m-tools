<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java"
    import="java.util.*,
    com.l5m.common.bean.*, 
    com.l5m.common.l5m_util.bean.*,
    com.l5m.common.l5m_util.rld.*,
    com.l5m.common.util.*,
    org.ajaxanywhere.AAUtils,
    com.l5m.!REPLACE_STYLE!.bean.*, 
    com.l5m.!REPLACE_STYLE!.engine.worker.*,
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
%><!-- --> 


<html>

    
    


    <l5m:jspHead useIE7Compatible="true"  title="${worker.APP_NAME}" formName="${formName}" packageName="${packageLowerCase}" planingCss="L001;L004">
        
        <!-- add additinal js css in here -->
        <link href="<%=request.getContextPath()%>/htdoc/datepicker-lite.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="<%=request.getContextPath()%>/tagresources/javascript/timeSpan/datepicker-lite.js "></script> 
   
		<script type="text/javascript" src='<%=request.getContextPath()%>/tagresources/javascript/TopBar2.js'></script> 
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/tagresources/css/TopBar2/TopBar2_${packageUpperCase}.css" /> 
        <!--  addtion javascript here -->
        <%@ include file="CommonVariables.jsp"%> 
        <c:set var="colors" value="<%=colors%>" scope="request"/> 
        <script type="text/javascript"><!--
            ajaxAnywhere.formName = "${worker.FORM_NAME}";   
            var QHTAjaxObject = new QHTAjaxUtil('<%=request.getContextPath()%>/servlet/L5MOnline/<%=AppConfig.getProperty("appL5MOnline")%>','${worker.url}','<%=AppConfig.getProperty("butOption")%>'); 
            var pageAction = new PageAction(window, "${worker.FORM_NAME}", "<%=AppConfig.getProperty("butOption")%>", "panelIndex" , "displayStage" , '<%=request.getContextPath()%>/servlet/L5MOnline?work=ForwardToJspWorker&jsp=IntermediaRefreshN&irStatus=firstTime&showLocalForm=N')

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
            <form class="formnomargin" name="${worker.FORM_NAME}"  id="${worker.FORM_NAME}"  action="<%=AppConfig.getProperty("appL5MOnline")%>" method="post">
                <input type="hidden" name="<%=AppConfig.getProperty("requestAction")%>" id="<%=AppConfig.getProperty("requestAction")%>" value="${worker.WORKER_NAME}" />
                <input type="hidden" name="<%=AppConfig.getProperty("srcPage")%>" id="<%=AppConfig.getProperty("srcPage")%>" value="${worker.jspGoto}" />
                <input type="hidden" name="<%=AppConfig.getProperty("butOption")%>" id="<%=AppConfig.getProperty("butOption")%>"  value="" /> 
                <input type="hidden" name="1stnavbar" id="1stnavbar" value="<%=request.getParameter("1stnavbar")%>" /> 
                <input type="hidden" name="2ndnavbar" id="2ndnavbar" value="<%=request.getParameter("2ndnavbar")%>" /> 
                <input type="hidden" name="<%=SessionConstants.NAV_COMPANY_ID%>" value="${worker.servicer.companyId}" /> 
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
                                            <tr  bgcolor='#FFDDDD'>
                                                <td nowrap="nowrap" width="25%" style="text-align:left" >&nbsp;</td>
                                                <td nowrap="nowrap" width="50%" style="text-align:center"  >
                                                    <b> <a href="javascript:pageAction.submit('<%=ActionConstants.SUBMIT%>')"><img   style='border:none' src="<%=request.getContextPath()%>/image/gif/submitBut.gif"/></a></b>
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
                <div class="Q_reportBox" >  
                    <table border="0" cellpadding="0" cellspacing="0" width="100%" style="margin-left:2px; margin-top:5px" class="reportTable">
                        <tr>
                            <td align="left" valign="top" width="99%">
                                <aa:zone name="result"> 
                                    <div class="reportTopBox"> 
                                        <c:forEach items="${PANEL}" var="panel" varStatus="panelIndex">
                                            <c:if test="${panel.enable}">
                                                <c:set var="jsChangePanel">
                                                    javascript:pageAction.changePanel('${panelIndex.index}');
                                                </c:set> 
                                                <c:if test="${panelIndex.index ==worker.dataAvailability || panelIndex.index ==worker.help}">
                                                    <div   style=' ${worker.servicer.panelIndex == panelIndex.index ?"cursor: none" : ""} ; white-space:nowrap; ${ true ?"font-weight: bold" : ""} ; font-size:11px; border-top-width:0px;${panelIndex.first?"border-left-width:0px":""}'  nowrap id="displayBy_${panelIndex.index }" onclick="${baseServicerParameterBean.panelIndex== panelIndex.index ? '':(true? jsChangePanel:'')}" class="${worker.servicer.panelIndex== panelIndex.index? 'focus' : true ?'base':'base'}" >
                                                        ${panel.label}  
                                                    </div>  
                                                </c:if>
                                                <c:if test="${!(panelIndex.index ==worker.dataAvailability || panelIndex.index ==worker.help)}">
                                                    <div   style=' ${worker.servicer.panelIndex == panelIndex.index || !worker.servicer.displayStage ?"cursor: none" : ""} ; white-space:nowrap; ${worker.servicer.panelIndex == panelIndex.index || worker.servicer.displayStage ?"font-weight: bold" : ""} ; font-size:11px; border-top-width:0px;${panelIndex.first?"border-left-width:0px":""}'  nowrap id="displayBy_${panelIndex.index }" onclick="${baseServicerParameterBean.panelIndex== panelIndex.index ? '':(worker.servicer.displayStage? jsChangePanel:'')}" class="${worker.servicer.panelIndex== panelIndex.index? 'focus' :worker.servicer.displayStage?'base':'base'}" >
                                                        ${panel.label }  
                                                    </div>   
                                                </c:if>
                                            </c:if> 
                                        </c:forEach>   
                                        <div class="last">&nbsp;</div>
                                    </div>     
                                   <div style='clear:both'/> 
                                       <table width="100%">
                                        <tr> 
                                        <td  nowrap="nowrap"  height="40px" style="padding-left:5px;" >      
                                        </td> 
                                        <td  nowrap="nowrap"  height="40px" style="text-align:right;">         
                                            ${worker.renderPaginatorHTML} 
                                         </td>
                                        </tr>
                                    </table> 
                                   
                                    
                                        <table border="0" cellpadding="0" cellspacing="0" width="100%" >
                                        <tr>  <td  nowrap="nowrap" align='left' >    
                                              <c:if test="${baseServicerParameterBean.panelIndex !=worker.help && baseServicerParameterBean.panelIndex !=worker.dataAvailability}" > 
                                               </c:if>
                                         </td></tr>
                                        <tr>   
                                        <td  nowrap="nowrap" align='center' >    
                                             ${worker.renderHTML}  
                                         </td>
                                        </tr>
                                    </table> 
                                       
                                        
                                        
                                 
                                   
                                   
                                   
                                   <c:if test="${baseServicerParameterBean.panelIndex ==worker.help}">
                                        <!-- the div of descriptionTab -->
                                        <div id="descriptionTab"><br/><br/><l5m:appDesc
                                            navigationBean="${worker.navigationBean}" style="${styleLowerCase}" id="navDesc" />
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
                                    <c:if test="${!empty paraBean.sortWrappers[paraBean.panelIndex]}">     
                                         <c:forEach var="sortWrapper" items="${paraBean.sortWrappers[paraBean.panelIndex]}">                                            
                                            <c:if test="${!empty sortWrapper.sortingKeysModuleStateBean}">
                                                <l5m:sortingKeysModule2 style="${styleLowerCase}"   moduleTitle="Sort By"     
                                            sortingKeysModuleStateBean="${sortWrapper.sortingKeysModuleStateBean}"  
                                            id="${sortWrapper.sortingKeysModuleStateBean.id}"/>                                            
                                            </c:if>                                         
                                         </c:forEach> 
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
                                        <c:if test="${!empty paraBean.displayWrappers[paraBean.panelIndex]}">     
                                         <c:forEach var="displayWrapper" items="${paraBean.displayWrappers[paraBean.panelIndex]}">                                            
                                            <c:if test="${!empty displayWrapper.columnsMap}">
                                                     <l5m:multipleSelect
                                                 id="${displayWrapper.id}"
                                                 style="${styleLowerCase}"
                                                 title="${displayWrapper.title}"
                                                 sourceValues="${displayWrapper.columnsMap}"
                                                 selectedValues="${displayWrapper.selectedColumns }"
                                                 onChange=""
                                                 displayMode="2"
                                                 useSortBy="true"
                                                 sortBy="1"
                                                 sortField="2"
                                                 selectedLabel="Select"
                                                 sourceLabel="${displayWrapper.title}"
                                                 sourceWidth="200"
                                                 destinationWidth="200"
                                                 sourceSize="5"
                                                 destinationSize="5"
                                            />                                       
                                            </c:if>                                         
                                         </c:forEach> 
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
  
         