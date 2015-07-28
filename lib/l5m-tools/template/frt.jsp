<!DOCTYPE html>
<%@ page language="java"
  import="java.util.*,
  com.l5m.common.bean.*, 
  com.l5m.common.l5m_util.bean.*,
  com.l5m.common.l5m_util.rld.*,
  com.l5m.common.util.*,
  org.ajaxanywhere.AAUtils,
  com.l5m.!REPLACE_STYLE!.bean.*, com.l5m.customtags.beans.*, com.l5m.customtags.tags.*,
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
<c:set var="styleLowerCase" value="${worker.styleLowerCase}" />
<c:set var="styleUpperCase" value="${worker.styleUpperCase}" />>
<c:set var="PANEL" value="${worker.PANEL}"/>
<%
if(AAUtils.isAjaxRequest(request)){
  AAUtils.addZonesToRefresh(request, "alwaysRefreshZone,"+ ((String)request.getAttribute("refreshZones"))); 
}  
%>
    <c:set var='jsCache' value='<%="&__jstimeunique="+System.currentTimeMillis()%>'/>        
    <c:set var='theme' value='${worker.navigationBean.theme}' />
    <c:set var='_request' value="<%=request%>"/>
    <c:set var="isIE9Below" value="${l5mfunctions:isIE9Below(_request)}"/>
    <%

        CSSImportParaBean _cssImport = new CSSImportParaBean(request.getContextPath(), "ms2", 1);
        JSImportParaBean _jsImport = new JSImportParaBean(request.getContextPath());

    %>
<html>

  
  


  <l5m:jspHead useIE7Compatible="true" useCssImport='1' cssImportParaBean="<%=_cssImport%>" jsImportParaBean="<%=_jsImport%>" includeJQuery='true' title="${worker.APP_NAME}" formName="${formName}" packageName="${packageLowerCase}" planingCss="L001;L004">
    
    <!-- add additinal js css in here -->
    <link href="<%=request.getContextPath()%>/htdoc/datepicker-lite.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="<%=request.getContextPath()%>/tagresources/javascript/timeSpan/datepicker-lite.js "></script> 
   
    <script type="text/javascript" src='<%=request.getContextPath()%>/tagresources/javascript/TopBar2.js'></script> 
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/tagresources/css/TopBar2/TopBar2.css" /> 
    <!--  addtion javascript here -->
    <%@ include file="CommonVariables.jsp"%> 
    <c:set var="colors" value="<%=colors%>" scope="request"/> 
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
      table{
        border-collapse:collapse;
      }
      .grid .TD{border-top:1px dotted #888888;}
      .grid .LD{border-left:1px dotted #888888;}
      .grid .row{line-height:33px;}
      .grid label{white-space:nowrap;}
    </style> 
    
    
 
  
    
    <l5m:LoadResources/>
    
  </l5m:jspHead> 
  
  <l5m:jspBody 
    formName="${worker.FORM_NAME}"  packageName="${packageLowerCase}" 	style="${styleLowerCase}"
    worker="${worker.WORKER_NAME}"  action=""  jspGoto="${worker.jspGoto}"
    groupId="${servicer.groupId}"  	companyId="${servicer.companyId}"
    userId="${servicer.userId}"
    dbHandler="${servicer.dbHandler}"  includeJQuery="true"
  >
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
               id="${paraBean.topBarStateBean.id}"
               topBarItems='${worker.topBarItems}'
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
                    <c:set var='leftstyle' value='line-height:33px;width:200px;padding-left:7px;border-bottom:1px dotted #888; font-weight:bold;' />
                    <c:set var='righstyle' value='padding-left:10px;border-bottom:1px dotted #888;border-left:1px dotted #888;'/>
                    
                    <l5m:tabPanel2
                     id="${baseServicerParameterBean.tabPanelID}" 
                    captions="${baseServicerParameterBean.tabbedPanelCaptions}" 
                    selected="${baseServicerParameterBean.selectedTab}" 
                    hiddenCaptions="${baseServicerParameterBean.hiddenPanelCaptions}"
                    style="${styleLowerCase}"
                    showDisplayControl="false"> 
                    <l5m:tab2>
                      <div class="text">  
                        <table border="0" cellspacing="0" cellpadding="0" width="100%"  style='height:100%;font-size:11px;'>  
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
                                 <tr class="row">
                                      <td class="TD" style="${leftstyle};" nowrap valign="top"> </td>
                                      <td class="TD LD" style="${righstyle}; line-height:16px;">
                                     
                                      </td>
                                  </tr>
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
                    <l5m:resultZone
                            panels='${PANEL}'
                            formName="${worker.FORM_NAME}"  packageName="${packageLowerCase}"   style="${styleLowerCase}"
                            groupId="${servicer.groupId}"   companyId="${servicer.companyId}"
                            userId="${servicer.userId}" 
                            dbHandler="${servicer.dbHandler}" usingDefaultPaginatorRender='false'
                            
                        />
                </aa:zone> 
              </td>
            </tr>
          </table>   
        </div>
        <!--report panel end-->
         
        <!--  dialog -->
        
              
        <l5m:dialog
            id="sortDialog"
            title="Sort"
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
            canClose="true"
            style="${styleLowerCase}"> 
            <aa:zone name="displayDialogZone"> 
              
                <table>
                  <tr>
                  <td style="text-align:left;white-space:nowrap;" valign="top">  
                    <c:if test="${!empty paraBean.displayWrappers[paraBean.panelIndex]}">   
                     <c:forEach var="displayWrapper" items="${paraBean.displayWrappers[paraBean.panelIndex]}">                      
                     <c:if test="${!empty displayWrapper.columnsMap}">
                          <div style="${displayWrapper.hidden?'display:none;':''}">
                            <l5m:multipleSelect
                         id="${displayWrapper.id}"
                         style="${styleLowerCase}"
                         title="${displayWrapper.title}"
                         sourceValues="${displayWrapper.columnsMap}"
                         selectedValues="${displayWrapper.selectedColumns }"
                         selectedValue="${displayWrapper.selectedValue}"
                         onChange=""
                         displayMode="${displayWrapper.displayMode}"
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
                      </div>               
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
 
      
        <l5m:dialog
          id="excelDialog"
          title="Export Option"
          overlayZIndex="100"
          dialogWidth="700px"
          canClose="true"
          style="${styleLowerCase}"> 
            <aa:zone name="exportDialogZone">  
               <l5m:ExcelOption
                  id="${servicer.excelOption.id}"
                  stateBean="${servicer.excelOption}"
                  style='${styleLowerCase}' includeCSV="true"
                />
            <script  type="text/javascript">
              <c:if test="${worker.showDialog}">	 
                $('excelDialog').show();
              </c:if>
            </script> 				  
           </aa:zone>
          <l5m:dialogBottom>
            <a href="javascript:pageAction.hideDialog('excelDialog');pageAction.clickExportButton('<%=ActionConstants.EXPORT_EXCEL%>');">[OK]</a>
              &nbsp;&nbsp;
            <a href="javascript:pageAction.hideDialog('excelDialog');">[Cancel]</a>
              &nbsp;&nbsp;
            <a href="javascript:pageAction.clickExportButton('<%=ActionConstants.EXPORT_EXCEL%>');">[Apply]</a>
          </l5m:dialogBottom>
        </l5m:dialog>
    
        <!-- end dialog -->
  
  </l5m:jspBody>
</html>
  
     