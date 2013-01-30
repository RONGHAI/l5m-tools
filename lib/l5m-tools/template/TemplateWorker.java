package com.l5m.!REPLACE_STYLE!.engine.worker;

import static com.l5m.common.util.ActionConstants.DISPLAY_REFRESH;
import static com.l5m.common.util.ActionConstants.EXPORT_EXCEL;
import static com.l5m.common.util.ActionConstants.EXPORT_PDF;
import static com.l5m.common.util.ActionConstants.FILTER_REFRESH;
import static com.l5m.common.util.ActionConstants.SORT_RERESH;
import static com.l5m.common.util.ActionConstants.SUBMIT;
import static com.l5m.common.util.dcnds.QHTCommonUtil.AA_REFRESH_ZONES_NAME;
import static com.l5m.common.util.dcnds.QHTCommonUtil.JSON_REFRESH_TYPE;
import static com.l5m.common.util.dcnds.QHTCommonUtil.PROGRESS_PAGE_POSTBACK;
import static com.l5m.common.util.dcnds.QHTCommonUtil.REFRESH_TYPE;
import static com.l5m.customtags.tags.utils.GenerateTagUtil.parseModuleStateBean;

import java.io.IOException;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringEscapeUtils;

import com.l5m.common.bean.NavigationBean;
import com.l5m.common.bean.NavigationItemBean;
import com.l5m.common.bean.StatusMessageBean;
import com.l5m.common.engine.exporter.ExportInformationBean;
import com.l5m.common.engine.servicer.ServicerType;
import com.l5m.common.engine.worker.AbstractWorker;
import com.l5m.common.util.ActionConstants;
import com.l5m.common.util.AppConfig;
import com.l5m.common.util.AppLog;
import com.l5m.common.util.CommonProperty;
import com.l5m.common.util.DataUtil;
import com.l5m.customtags.beans.BaseServicerParaBean;
import com.l5m.customtags.module.statebean.MultipleSelectStateBean;
import com.l5m.customtags.module.statebean.PaginatorStateBean;
import com.l5m.customtags.module.statebean.SortingKeysModuleStateBean;
import com.l5m.customtags.module.statebean.TopBar2StateBean;
import com.l5m.customtags.tags.Paginator2Tag;
import com.l5m.customtags.tags.utils.GenerateTagUtil;
import com.l5m.customtags.tags.utils.IconStatus;
import com.l5m.customtags.tags.utils.TopBarIcon;
import com.l5m.!REPLACE_STYLE!.engine.servicer.!REPLACE_ME_FILE!ServicerImpl;
import com.l5m.!REPLACE_STYLE!.engine.servicer.!REPLACE_ME_FILE!ServicerImpl.PANEL;

public class !REPLACE_ME_FILE!Worker extends AbstractWorker{
 
    

    public static  enum Descriptions{
        Initializing("Initializing") , RetrievingData("Retrieving Data"),  CreatingReport("Creating Report"), Finalize("Finalize") 
        ; 
         private final String label;
         Descriptions(){
            this.label = this.name();
        }
         Descriptions(String label){
            this.label = label;
        } 
        public String getLabel() {
            return label;
        }
    }
    public static final String JSP_TOGO_PERIX = "!REPLACE_ME_FILE!";  /*worker name w/o "Worker"*/
    public static final String JSP_TOGO = JSP_TOGO_PERIX+".jsp"; 
    public static final String WORKER_NAME = JSP_TOGO_PERIX+"Worker"; 
    
     
    
    public static final String FORM_NAME = JSP_TOGO_PERIX+"Form";
    public static final String packageLowerCase = "!REPLACE_STYLE!";
 
    public static final String packageUpperCase =  packageLowerCase.toUpperCase();
     

    public  static  StatusMessageBean initStatusMessageBean(HttpSession session,Descriptions [] descriptions , String extra){
        
        StatusMessageBean messageBean = new StatusMessageBean(); 
        for (int i = 0; i < descriptions.length; i++) {
            messageBean.addStep((i==0?extra:"")+descriptions[i].getLabel());
        }  
        StringBuffer messageBuffer = new StringBuffer();
        messageBean.setMessageBuffer(messageBuffer);
        session.setAttribute(CommonProperty.IntermediaMessage, messageBuffer);
         
        return messageBean;
    }

    public static StatusMessageBean initStatusMessageBean(HttpSession session, String [] descriptions, String extra) {
        StatusMessageBean messageBean = new StatusMessageBean();
        for (int i = 0; i < descriptions.length; i++) {
            messageBean.addStep((i == 0 ? extra : "") + descriptions[i]);
        }

        StringBuffer messageBuffer = new StringBuffer();
        messageBean.setMessageBuffer(messageBuffer);
        session.setAttribute(CommonProperty.IntermediaMessage, messageBuffer);

        return messageBean;
    }
    public static void main(String[] x) {
         //System.out.println(StringEscapeUtils.escapeHtml( "NETWORKPROGRAM"));
    }
    @ServicerType("com.l5m.!REPLACE_STYLE!.engine.servicer.!REPLACE_ME_FILE!ServicerImpl")
    private !REPLACE_ME_FILE!ServicerImpl  servicer; 
    protected String btnClicked; 
    
    protected boolean needForwordToJsp = true;

    protected NavigationBean navigationBean;

    private boolean showDialog = false;
 

    public !REPLACE_ME_FILE!Worker() {
        this.navigationBean = new NavigationBean();
        this.navigationBean.setJSPGoTo(JSP_TOGO);
         
     
    }

    protected void bindParams(HttpServletRequest request) { 
        this.btnClicked = (super.getParamValueString(AppConfig.getProperty("butOption"), "N/A"));
        String refresh = request.getParameter(REFRESH_TYPE);
        this.needForwordToJsp = !(refresh != null && refresh.equals(JSON_REFRESH_TYPE));
        if (this.btnClicked.equals(PROGRESS_PAGE_POSTBACK) || (refresh != null && refresh.equals(JSON_REFRESH_TYPE))) {
            return;
        }

        BaseServicerParaBean baseServicerParameterBean = this.servicer.getBaseServicerParameterBean();
        try {
            baseServicerParameterBean.setPanelIndex(Integer.parseInt(request.getParameter("panelIndex")));
        } catch (Exception e) {
            baseServicerParameterBean.setPanelIndex(0);
        }
        baseServicerParameterBean.setSelectedTab(StringEscapeUtils.unescapeHtml( super.getParamValueString("accordionTestTop:selected", "SOURCE" )));     
        this.servicer.getBaseServicerParameterBean().getTopBarStateBean().setId("TopBar").parseOnlyStartStatus(request);  
        
        // use method from GenerateTagUtil to parse tags
        
           
     
     }
    private void bindParamsDisplayAndSort(HttpServletRequest request) {
        this.servicer.getBaseServicerParameterBean().bindTopBart(request, "TopBar");
    }
 
    
     
    
    private void changeDecimalAction() {
        this.setRefreshZones("result"); 
        this.servicer.setReportDecimalControlList(TopBar2StateBean.parseOnlyDecimal(this.getRequest(), "TopBar" ).getValue());

    }

    
 
 
    
    

     
 
    private void changePaginatorAction() {
        PaginatorStateBean stateBean = this.servicer.getPaginatorStateBean();
        stateBean.parse(this.getRequest());
        this.servicer.handlePaginator(this.servicer.getPanelIndex());
        this.setRefreshZones("panelZone,result");
  
    }
    
     

    
    private void changePanelAction() {
        this.setRefreshZones("result,topNavigationZone,sortDialogZone,filterDialogZone,displayDialogZone");

    }
    
    
     
    
    
    public void changeSortDisplayModeAction() {
        String sortBy  = this.servicer.getBaseServicerParameterBean().getSelectedSortBy(); 
        this.bindParamsDisplayAndSort(this.getRequest());  
        
        Set<String> displayBy =  this.servicer.getBaseServicerParameterBean().getSelectedDisplayBy();
        
        if(!this.servicer.getBaseServicerParameterBean().getSelectedDisplayBy().equals( displayBy)){
            this.servicer.updateDisplay();
        } 
        if(!this.servicer.getBaseServicerParameterBean().getSelectedSortBy().equals(sortBy)   ){
            this.servicer.sort(); 
        }
    
         this.setRefreshZones("result,sourcePanelZone");

    }
    
    
    
/*    private String baseDir(String subLevel) {
        return getCurvePath() + "" + this.servicer.getUserId() + "/" + navigationBean.getProgramKey() + "/" + subLevel+"/";
    }
 
    
    */
     
    
     
 

    public void changeTimeAction() {
        this.servicer.getBaseServicerParameterBean().changeTime(this.getRequest());  
        this.setRefreshZones("sourcePanelZone");
        
        if(this.servicer.isDisplayStage()){
            this.clearResultAction();
        } 
    }

 

    public void clearResultAction() {
        this.servicer.clearCache();
        this.servicer.getBaseServicerParameterBean().setPanelIndex(PANEL.Help.panelIndex());
        this.servicer.getBaseServicerParameterBean().setDisplayStage(false);
        this.setRefreshZones("result,sourcePanelZone");
    }

    @SuppressWarnings("unchecked")
    public void displayRefreshAction() {
        MultipleSelectStateBean messuare = new MultipleSelectStateBean();
        messuare.setSelectedValues(new HashSet<String>());
        messuare.setId("multipleColumnsController");
        messuare.parse(this.getRequest());
        if(servicer.getColumnsMap() != null){
            boolean[] displayControllerMeasurement = new boolean[servicer.getColumnsMap().size()];
            if (messuare.getSelectedValues() != null) {
                displayControllerMeasurement = messuare.getSelectedValueBoolean(servicer.getColumnsMap());
                this.servicer.setDisplayController(displayControllerMeasurement); 
            }
            this.servicer.setSelectedColumns(messuare.getSelectedValues() == null ? (new HashSet<String>()) : (HashSet<String>) messuare.getSelectedValues()); 
        }
        
        
        this.servicer.updateDisplay();
        this.setRefreshZones("result");
    }

 

    public void exportExcelAction() {
        this.needForwordToJsp = false;
        @SuppressWarnings("unused")
        ExportInformationBean informationBean = this.getExportInformationBean(); 
         
    }

    public void exportPDFAction() { 
        this.needForwordToJsp = false;
    }

    public void filterRefreshAction() {  
        this.servicer.processFilter(); 
        this.setRefreshZones("result");
        //    
    }

    

    /**
     * @return the aPP_NAME
     */
    public String getAPP_NAME() {
        @SuppressWarnings("unchecked")
        Map<String, NavigationItemBean> navBarAccessMap = (Map<String, NavigationItemBean>) this.getRequest().getSession().getAttribute("navAccessBean");
        String displayName = null;
        try {
            displayName = navBarAccessMap.get(this.navigationBean.getProgramKey()).getDisplayName();
        } catch (Exception e) {
        }
        if (displayName != null)
            return displayName;
        return "";
    }
      
  

    /**
     * @return the btnClicked
     */
    public String getBtnClicked() {
        return btnClicked;
    }

 
     

    public int getDataAvailability() {
        return PANEL.DataAvailability.panelIndex();
    }

 
 
    @SuppressWarnings({ "unchecked"})
    private ExportInformationBean getExportInformationBean(){
        ExportInformationBean informationBean = null;
        try {
            informationBean = new ExportInformationBean(this.navigationBean, (HashMap) this.getSession().getAttribute(UserCompanyWorker.NAV_ACCESS_BEAN), DataUtil.getCompanyName(this.servicer.getDbHandler(), this.servicer.getCompanyId()), DataUtil.getUserFullName(this.servicer.getDbHandler(), this.servicer.getUserId()));
        } 
        catch (Exception e) {
            e.printStackTrace();
        }
        return informationBean;
    }

    /**
     * @return the fORM_NAME
     */
    public String getFORM_NAME() {
        return FORM_NAME;
    }

    public int getHelp() {
        return PANEL.Help.panelIndex();
    }



    /**
     * @return the jSP_TOGO
     */
    public String getJSP_TOGO() {
        return JSP_TOGO;
    }

    public String getJspGoto() {
        return JSP_TOGO;
    }

    /**
     * @return the navigationBean
     */
    public NavigationBean getNavigationBean() {
        return navigationBean;
    }

    public String getPackageLowerCase() {
        return packageLowerCase;
    }

    public String getPackageUpperCase() {
        return packageUpperCase;
    }

    public PANEL[] getPANEL(){
        return PANEL.values();
    }

 
    public String getRenderHTML() {
        if(! hasData()) return "";
        try{  
         }catch(Exception e){
            e.printStackTrace();
        }
        return "";

    }

 
 
    public String getRenderPaginatorHTML() {
        if(!hasData()) return "";
        Paginator2Tag paginatorTag = GenerateTagUtil.getPaginator2Tag("PaginatorStateBeanTag", "pageAction.changePaginator();", this.servicer.getPaginatorStateBean());
        paginatorTag.setStyle(packageLowerCase);
        try {
            return paginatorTag.renderHTML();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }
     
    public !REPLACE_ME_FILE!ServicerImpl getServicer() {
        return servicer;
    }
    
     
     
    
     


    public String getUrl() {
        String workerParamName = AppConfig.getProperty("requestAction");
        String jspSrcParamName = AppConfig.getProperty("srcPage");
        String companyId = this.servicer.getCompanyId();
        StringBuilder url = new StringBuilder();
        //url.append(this.getRequest().getContextPath()+"/servlet/L5MOnline/").append(AppConfig.getProperty("appL5MOnline")).append("?");
        url.append(workerParamName).append("=").append(this.getRequest().getParameter(workerParamName)).append("&");
        url.append(jspSrcParamName).append("=" + JSP_TOGO + "&companyid=").append(companyId);
        url.append("&1stnavbar=").append(this.getRequest().getParameter("1stnavbar"));
        url.append("&").append(REFRESH_TYPE).append("=").append(JSON_REFRESH_TYPE);

        return url.toString();
    }

    /**
     * @return the wORKER_NAME
     */
    public String getWORKER_NAME() {
        return WORKER_NAME;
    }

    public boolean hasData(){
        final int panelIndex = this.servicer.getPanelIndex();
        if(panelIndex == PANEL.Help.panelIndex() || panelIndex == PANEL.DataAvailability.panelIndex()){
            return false;
        }
        return true;
    }

    protected void initWorker() {
        this.servicer.getBaseServicerParameterBean().setPanelIndex(PANEL.Help.panelIndex());
     
    }

    public boolean isShowDialog() {
        return showDialog;
    }

    private void popupDialogAction(String dialog) {
        this.showDialog = true;
        this.setRefreshZones(dialog+"Zone,"+dialog+"BottomZone"); 
    }

 

 
    /**
     * this method only dispatch btnClicked action, don't write another logic in this method.
     * all method should be use Action as suffix w/o or with btnClick as parameter as neccersy.
     * @param btnClicked
     */
    public void processButtonClickedAction(String btnClicked) { 
        if (btnClicked.equals(SUBMIT)) {
            this.submitAction();
        } else if (btnClicked.equals(EXPORT_EXCEL)) { 
            this.exportExcelAction();
        }  
        else if (btnClicked.equals(EXPORT_PDF)) { 
            this.exportPDFAction();
        } else if (btnClicked.equals(DISPLAY_REFRESH)) {
            this.displayRefreshAction();
        } else if (btnClicked.equals(SORT_RERESH)) {
            this.sortRefreshAction();
        } else if (btnClicked.equals(FILTER_REFRESH)) {
            this.filterRefreshAction();
        } else if (btnClicked.equals("changeSortDisplayMode")) {
            this.changeSortDisplayModeAction();
        } else if (btnClicked.equals("clearResult")) {
            this.clearResultAction();
        } else if (btnClicked.equals("changeTime")) {
            this.changeTimeAction();
        } else if (btnClicked.equals("changeDecimal")) {
            this.changeDecimalAction();
        } else if ("resetDialog".equals(btnClicked)) {
            this.resetDialogAction();
        } else if ("changePanel".equals(btnClicked)) {
            this.changePanelAction();
        } else if ("changePaginator".equals(btnClicked)) {
            this.changePaginatorAction();
        } 
        else if(btnClicked.endsWith("Dialog")){
            this.popupDialogAction(btnClicked);
        }  
        else {

        }

    }

    @Override
    public void processRequest() {
          
        this.getResponse().setContentType("text/html");
        this.getRequest().setAttribute(AA_REFRESH_ZONES_NAME, getRequest().getParameter(AA_REFRESH_ZONES_NAME));
        this.getSession().setAttribute(CommonProperty.JobDoneIndicator, "N");
        this.getSession().setAttribute(CommonProperty.EndJspPageName, JSP_TOGO_PERIX);
        this.needForwordToJsp = true;

        if (isFromOtherPages(JSP_TOGO)) {
            this.initWorker();
        } else {
            this.bindParams(getRequest());
            if (this.btnClicked != null && this.btnClicked != "" && (!this.btnClicked.equals(""))) {
                this.processButtonClickedAction(this.btnClicked);
            }
        }
        if (this.needForwordToJsp && (!getResponse().isCommitted())) {
            try {
                this.getSession().setAttribute(CommonProperty.JobDoneIndicator, "Y");
                forwardToJsp(JSP_TOGO);
            } catch (IOException e) {
                e.printStackTrace();
                AppLog.error(this + ":Exception " + e.getMessage());
            } catch (ServletException e) {
                e.printStackTrace();
                AppLog.error(this + ":Exception " + e.getMessage());
            }
        }
        

    }
    
    private void resetDialogAction() {
        this.setRefreshZones("sourcePanelZone,topNavigationZone,sortDialogZone,filterDialogZone,displayDialogZone");
    }

    public void setRefreshZones(String zones) {
        this.getRequest().setAttribute(AA_REFRESH_ZONES_NAME, zones);
    }
 
    
    public void setServicer(!REPLACE_ME_FILE!ServicerImpl servicer) {
        this.servicer = servicer;
    }
     
    

    public void setShowDialog(boolean showDialog) {
        this.showDialog = showDialog;
    }
     
    

    public void sortRefreshAction() {
        
        try{
            SortingKeysModuleStateBean sortingKeysModuleStateBean = parseModuleStateBean(this.servicer.getSortingKeysModuleStateBean(),
                    this.servicer.getSortingKeysModuleStateBean().getId(), this .getRequest()); 
            this.servicer.setSortingKeysModuleStateBean(sortingKeysModuleStateBean);
        }catch(Exception e){ 
        }
        
        this.servicer.sort(); 
        this.setRefreshZones("result");

    }

    public void submitAction() {
         this.servicer.getBaseServicerParameterBean().changeTime(this.getRequest()); 
         
            
        StatusMessageBean messageBean = initStatusMessageBean(  this.getSession(), Descriptions.values(),"");
        this.servicer.getBaseServicerParameterBean().setSelectionPanelStatusOpen(false);
        this.servicer.getBaseServicerParameterBean().setMessageBean(messageBean);

        messageBean.reset();
        this.getAppStatusServicer().setStatusMessageBean(messageBean);
        messageBean.setCurrentStep(Descriptions.Initializing.ordinal());
         
        this.servicer.clearCache();
        this.servicer.getBaseServicerParameterBean().setPanelIndex(0);
        
        messageBean.setCurrentStep(Descriptions.RetrievingData.ordinal());
        try { 
             
            this.servicer.retrieveData();  
        } catch (Exception e) {
            e.printStackTrace();
        }
        messageBean.setCurrentStep(Descriptions.CreatingReport.ordinal());   
         
        
          this.servicer.sort();  
        this.servicer.updateDisplay();
 
        
        messageBean.setCurrentStep(Descriptions.Finalize.ordinal());   
        this.servicer.getBaseServicerParameterBean().setDisplayStage(true);
        this.servicer.getBaseServicerParameterBean().setSelectionPanelStatusOpen(false);  
        this.setRefreshZones("");  
        messageBean.setStepCompleted(Descriptions.Finalize.ordinal() );
        this.getAppStatusServicer().setCompleted(true); 

    }




    public String[] getActions() {
        return new String[] { 
                "", 
                "pageAction.showDialog('filterDialog')", // filter
                "", // search
                "", // highlight
                "pageAction.showDialog('sortDialog')", // sort
                "pageAction.showDialog('displayDialog')", // display
                "pageAction.clickButton('changeDecimal')", // decimal
                "pageAction.clickExportButton('" + ActionConstants.EXPORT_EXCEL + "')", // excel
                "pageAction.clickExportButton('" + ActionConstants.EXPORT_PDF + "')", // pdf
                "pageAction.showDialog('optionDialog')", // options
                "pageAction.showDialogDirectly('emailDialog')", // email
                 "pageAction.clickButton('changeSortDisplayMode')", // inc

        };
    }
    public TopBarIcon[] getTopBarIcons() { 
        return new TopBarIcon[] { 
                TopBarIcon.Start, 
                TopBarIcon.Filter, 
                TopBarIcon.Search, 
                TopBarIcon.Highlight, 
                TopBarIcon.Sort, 
                TopBarIcon.Display, 
                TopBarIcon.Decimal, 
                TopBarIcon.Excel,
                TopBarIcon.PDF, 
                TopBarIcon.Options, 
                TopBarIcon.Email,   
                TopBarIcon.IncIcon ,
                };

    }
    
    public IconStatus[] getIconsStatus() { 
        final boolean hasData = this.hasData();
        return new IconStatus[] { 
                this.servicer.getBaseServicerParameterBean().isSelectionPanelStatusOpen() ? IconStatus.open : IconStatus.close, 
                hasData? IconStatus.active :IconStatus.inactive,  // filter
                IconStatus.inactive, // search
                IconStatus.inactive, // highlight
                hasData? IconStatus.active :IconStatus.inactive, // sort
                hasData? IconStatus.active :IconStatus.inactive, // display
                hasData? IconStatus.active :IconStatus.inactive, // decimal
                hasData? IconStatus.active :IconStatus.inactive, // excel
                IconStatus.inactive, // pdf
                IconStatus.inactive, // options
                hasData? IconStatus.active :IconStatus.inactive, // email
                 IconStatus.active, // inc
        };

    }
}
