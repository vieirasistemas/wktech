object dmMain: TdmMain
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 364
  Width = 471
  object fdcWKTech: TFDConnection
    Params.Strings = (
      'DriverID=MySQL')
    Left = 40
    Top = 24
  end
  object fdpMySQL: TFDPhysMySQLDriverLink
    Left = 40
    Top = 72
  end
end
