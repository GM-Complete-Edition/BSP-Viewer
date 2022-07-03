program BSPView_v2_0;

{$R 'res\BSPView.res' 'res\BSPView.rc'}

uses
  FastMM4,
  Forms,
  BSPview_2_0 in 'BSPview_2_0.pas' {FormBSP},
  BSPLib in 'BSPLib.pas',
  BSPMeshLib in 'BSPMeshLib.pas',
  BSPCntrLib in 'BSPCntrLib.pas',
  Editors in 'Editors.pas',
  ColorPicker in 'ColorPicker.pas' {ColorPickerForm},
  DAEExportF in 'DAEExportF.pas' {DAEExportForm},
  SettingF in 'SettingF.pas' {SettingsForm},
  DAEImportF in 'DAEImportF.pas' {DAEImportForm},
  AddTemplate in 'AddTemplate.pas' {TemplateForm},
  AddChunk in 'AddChunk.pas' {AddChunk},
  ChangeAnimSpeed in 'ChangeAnimSpeed.pas' {AnimSpeed},
  AddEntities in 'AddEntities.pas';

begin
  Application.Initialize;
  Application.CreateForm(TFormBSP, FormBSP);
  Application.CreateForm(TDAEExportForm, DAEExportForm);
  Application.CreateForm(TSettingsForm, SettingsForm);
  Application.CreateForm(TColorPickerForm, ColorPickerForm);
  Application.CreateForm(TDAEImportForm, DAEImportForm);
  Application.CreateForm(TTemplateForm, TemplateForm);
  Application.CreateForm(TAddChunk, AddChunkForm);
  Application.CreateForm(TAnimSpeed, AnimSpeedForm);
  Application.CreateForm(TAddEntities, AddEntitiesForm);
  Application.Run;
end.
