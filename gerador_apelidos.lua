-- Carregando a biblioteca wxLua
local wx = require("wx")

-- Função para gerar um número aleatório entre dois valores
local function randomRange(min, max)
    return math.random(min, max)
end

-- Função para gerar um apelido aleatório com um número específico de sílabas
local function generateNickname(numSyllables)
    local syllables = {"ba", "be", "bi", "bo", "bu", "ca", "ce", "ci", "co", "cu", "da", "de", "di", "do", "du", "fa", "fe", "fi", "fo", "fu", "ga", "ge", "gi", "go", "gu", "ha", "he", "hi", "ho", "hu", "ja", "je", "ji", "jo", "ju", "ka", "ke", "ki", "ko", "ku", "la", "le", "li", "lo", "lu", "ma", "me", "mi", "mo", "mu", "na", "ne", "ni", "no", "nu", "pa", "pe", "pi", "po", "pu", "ra", "re", "ri", "ro", "ru", "sa", "se", "si", "so", "su", "ta", "te", "ti", "to", "tu", "va", "ve", "vi", "vo", "vu", "xa", "xe", "xi", "xo", "xu", "za", "ze", "zi", "zo", "zu", "an", "en", "in", "on", "un"}
    
    local nickname = ""
    
    for i = 1, numSyllables do
        local index = randomRange(1, #syllables)
        nickname = nickname .. syllables[index]
    end
    
    return nickname
end

-- Criação da janela principal
local frame = wx.wxFrame(wx.NULL, wx.wxID_ANY, "Gerador de Apelidos Aleatórios", wx.wxDefaultPosition, wx.wxSize(300, 200))

-- Criação dos controles
local label = wx.wxStaticText(frame, wx.wxID_ANY, "Número de Sílabas:")
local textCtrl = wx.wxTextCtrl(frame, wx.wxID_ANY, "2", wx.wxDefaultPosition, wx.wxDefaultSize, wx.wxTE_PROCESS_ENTER)
local button = wx.wxButton(frame, wx.wxID_ANY, "Gerar Apelido")
local resultLabel = wx.wxStaticText(frame, wx.wxID_ANY, "", wx.wxDefaultPosition, wx.wxDefaultSize, wx.wxALIGN_CENTER)

-- Função de evento do botão
local function OnGenerateNickname(event)
    local numSyllables = tonumber(textCtrl:GetValue())
    if numSyllables then
        local nickname = generateNickname(numSyllables)
        resultLabel:SetLabel(nickname)
    else
        resultLabel:SetLabel("Número inválido de sílabas!")
    end
end

-- Associação do evento ao botão
button:Connect(wx.wxID_ANY, wx.wxEVT_COMMAND_BUTTON_CLICKED, OnGenerateNickname)

-- Função de evento para a tecla Enter no campo de texto
local function OnEnterKeyPressed(event)
    OnGenerateNickname(event)
end

-- Associação do evento à tecla Enter
textCtrl:Connect(wx.wxID_ANY, wx.wxEVT_COMMAND_TEXT_ENTER, OnEnterKeyPressed)

-- Criação do sizer principal
local mainSizer = wx.wxBoxSizer(wx.wxVERTICAL)
mainSizer:Add(label, 0, wx.wxALL, 10)
mainSizer:Add(textCtrl, 0, wx.wxALL, 10)
mainSizer:Add(button, 0, wx.wxALL, 10)
mainSizer:Add(resultLabel, 1, wx.wxEXPAND + wx.wxALL, 10)

-- Definição do sizer principal para a janela
frame:SetSizerAndFit(mainSizer)

-- Exibição da janela
frame:Show(true)

-- Início do loop de eventos
wx.wxGetApp():MainLoop()
