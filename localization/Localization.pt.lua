if GetLocale() ~= "ptBR" then return end

local o = mOnWardrobe
if o.strings == nil then o.strings = {} end
local s = o.strings

s["Page N"] = "Página %i"
s["Refresh Instance"] = "Recarregar Instância"
s["Refresh Items"] = "Recarregar Itens"
s["Current Instance"] = "Instância Atual"
s["Click Refresh Info"] = "Clique no botão %s acima para carregar as instâncias"
s["Progress"] = "Progresso"
s["Missing Items"] = "Itens Faltando"
s["Instance"] = "Instância"
s["Hide List Option"] = "Esconder Lista quando abrir instância"
s["Refresh Confirmation"] = "Esta ação irá travar seu jogo por vários segundos. Deseja continuar?"
s["Yes"] = "Sim"
s["No"] = "Não"
s["Open Options"] = "Abrir Opções"
s["Options"] = "Opções"
s["Close"] = "Fechar"
s["Defaults"] = "Padrões"
s["General"] = "Geral"
s["Debug"] = "Debug"
s["Debug Info"] = "Estas opções são experimentais e podem quebrar seu jogo. Você foi avisado."
s["Disable Progress"] = "Desabilitar Progresso"
s["Disable Progress Info"] = "Deve aumentar a velocidade do processo de carregar items."

s["Refreshing"] = "Carregando"
s["Hide Minimap"] = "Esconder Botão do Minimapa"
