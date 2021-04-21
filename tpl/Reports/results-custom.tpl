{if $Report->ResultCount() > 0}
	<div id="report-actions">
		<a href="#" id="btnChart"><span class="fa fa-bar-chart"></span> {translate key=ViewAsChart}</a> |
		{if !$HideSave}
			<a href="#" id="btnSaveReportPrompt"><span class="fa fa-save"></span> {translate key=SaveThisReport}</a> |
		{/if}

		<a href="#" id="btnCsv"><span class="fa fa-download"></span> {translate key=ExportToCSV}</a> |
		<a href="#" id="btnPrint"><span class="fa fa-print"></span> {translate key=Print}</a> |
		<a href="#" id="btnCustomizeColumns"><span class="fa fa-filter"></span> {translate key=Columns}</a>

		<form id="saveSelectedColumns" method="post" role="form" action="{$smarty.server.SCRIPT_NAME}?{QueryStringKeys::ACTION}={ReportActions::SaveColumns}">
			<input {formname key=SELECTED_COLUMNS} id="selectedColumns" type="hidden" value="{$SelectedColumns}" />
		</form>
	</div>
	<div id="customize-columns"></div>
	<table width="100%" id="report-results" chart-type="{$Definition->GetChartType()}">
        <thead>
		<tr>
			{foreach from=$Definition->GetColumnHeaders() item=column}
				{capture name="columnTitle"}{if $column->HasTitle()}{$column->Title()}{else}{translate key=$column->TitleKey()}{/if}{/capture}
				<th data-columnTitle="{$smarty.capture.columnTitle}">
					{$smarty.capture.columnTitle}
				</th>
			{/foreach}
		</tr>
        </thead>
        <tbody>
		{foreach from=$Report->GetData()->Rows() item=row}
			{cycle values=',alt' assign=rowCss}
			<tr class="{$rowCss}">
				{foreach from=$Definition->GetRow($row) item=cell}
					<td chart-value="{$cell->ChartValue()}" chart-column-type="{$cell->GetChartColumnType()}"
						chart-group="{$cell->GetChartGroup()}">{$cell->Value()}</td>
				{/foreach}
			</tr>
		{/foreach}
        </tbody>
	</table>
	<h4>{$Report->ResultCount()} {translate key=Rows}
		{if $Definition->GetTotal() != ''}
			| {$Definition->GetTotal()} {translate key=Total}
		{/if}
	</h4>
{else}
	<h2 id="report-no-data" class="no-data" style="text-align: center;">{translate key=NoResultsFound}</h2>
{/if}

<script type="text/javascript">
	$(document).ready(function () {
		$('#report-no-data, #report-results').trigger('loaded');
	});
</script>
