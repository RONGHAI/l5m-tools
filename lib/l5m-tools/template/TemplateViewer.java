package com.l5m.!REPLACE_STYLE!.engine.exporter;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import com.l5m.customtags.export.BaseExcelHandler;
import com.l5m.customtags.export.BaseViewer;
import com.l5m.customtags.module.statebean.ExcelOptionStateBean;
import com.l5m.!REPLACE_STYLE!.engine.servicer.!REPLACE_ME_FILE!ServicerImpl;
import com.l5m.!REPLACE_STYLE!.engine.servicer.!REPLACE_ME_FILE!ServicerImpl.PANEL;
import com.l5m.!REPLACE_STYLE!.engine.worker.!REPLACE_ME_FILE!Worker;

public class !REPLACE_ME_FILE!Viewer  extends BaseViewer {
        protected boolean[] panelController;

    public !REPLACE_ME_FILE!Viewer(!REPLACE_ME_FILE!Worker worker, ExcelOptionStateBean excelOption, boolean isHTML) {
        super(excelOption, isHTML);
        this.servicer = worker.getServicer();
        this.exportInformationBean = this.servicer.getExportInformationBean();
         boolean[] panelController = servicer.getPanelController();
        if(panelController == null){
            panelController = new boolean[PANEL.values().length - 2];
            Arrays.fill(panelController, true);
        }
        this.UPPERCASE_STYLE = this.servicer.getExportInformationBean().getStyleLowerCase().toUpperCase();

        this.sheets = new String[PANEL.values().length - 2];
        List<String> list = new ArrayList<String>();
        for (int i = 0; i < sheets.length; i++) {
            if(!PANEL.values()[i].isEnable()){
                panelController[i] = false;
            }
            if(panelController[i]){
                list.add( PANEL.values()[i].getLabel());
            }
        }
        this.sheets = list.toArray(new String[list.size()]);
        this.rowPositions = new int[this.sheets.length];
        Arrays.fill(this.rowPositions, 4);
        this.panelController = panelController;
    }
    
    
    private static final long serialVersionUID = 1L;
    !REPLACE_ME_FILE!ServicerImpl servicer;

    @Override
    public void generateBody (BaseExcelHandler handler, boolean onlyCurrentReport) {
        if(!this.servicer.isDisplayStage()){
            return;
        }
        final int panelIndex = this.servicer.getPanelIndex();
        
        
        this.servicer.setPanelIndex(panelIndex);
        
    }

}
