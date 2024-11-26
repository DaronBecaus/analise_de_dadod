-- Tabela de Membros/Voluntários
CREATE TABLE Membros (
    MembroID INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(100) NOT NULL,
    DataNascimento DATE,
    CPF VARCHAR(14) UNIQUE,
    Email VARCHAR(100),
    Telefone VARCHAR(15),
    Endereco VARCHAR(200),
    DataBatismo DATE,
    DataMembresia DATE,
    StatusMembro ENUM('Ativo', 'Inativo') DEFAULT 'Ativo',
    Observacoes TEXT
);

-- Tabela de Áreas de Atuação/Ministérios
CREATE TABLE AreasAtuacao (
    AreaID INT PRIMARY KEY AUTO_INCREMENT,
    NomeArea VARCHAR(100) NOT NULL,
    Descricao TEXT,
    LiderResponsavel INT,
    RequisitosPrevios TEXT,
    FOREIGN KEY (LiderResponsavel) REFERENCES Membros (MembroID)
);

-- Tabela de Habilidades
CREATE TABLE Habilidades (
    HabilidadeID INT PRIMARY KEY AUTO_INCREMENT,
    NomeHabilidade VARCHAR(100) NOT NULL,
    Descricao TEXT
);

-- Tabela de Disponibilidade
CREATE TABLE Disponibilidade (
    DisponibilidadeID INT PRIMARY KEY AUTO_INCREMENT,
    DiaSemana ENUM(
        'Domingo',
        'Segunda',
        'Terça',
        'Quarta',
        'Quinta',
        'Sexta',
        'Sábado'
    ),
    PeriodoDia ENUM('Manhã', 'Tarde', 'Noite')
);

-- Tabela de Treinamentos
CREATE TABLE Treinamentos (
    TreinamentoID INT PRIMARY KEY AUTO_INCREMENT,
    NomeTreinamento VARCHAR(100) NOT NULL,
    Descricao TEXT,
    DataInicio DATE,
    DataFim DATE,
    Instrutor INT,
    FOREIGN KEY (Instrutor) REFERENCES Membros (MembroID)
);

-- Tabela de Relacionamento Membro-Área (Voluntariado)
CREATE TABLE MembroArea (
    MembroID INT,
    AreaID INT,
    DataInicio DATE,
    StatusVoluntario ENUM(
        'Ativo',
        'EmTreinamento',
        'Afastado'
    ),
    FuncaoEspecifica VARCHAR(100),
    PRIMARY KEY (MembroID, AreaID),
    FOREIGN KEY (MembroID) REFERENCES Membros (MembroID),
    FOREIGN KEY (AreaID) REFERENCES AreasAtuacao (AreaID)
);

-- Tabela de Relacionamento Membro-Habilidade
CREATE TABLE MembroHabilidade (
    MembroID INT,
    HabilidadeID INT,
    NivelExperiencia ENUM(
        'Básico',
        'Intermediário',
        'Avançado'
    ),
    PRIMARY KEY (MembroID, HabilidadeID),
    FOREIGN KEY (MembroID) REFERENCES Membros (MembroID),
    FOREIGN KEY (HabilidadeID) REFERENCES Habilidades (HabilidadeID)
);

-- Tabela de Relacionamento Membro-Disponibilidade
CREATE TABLE MembroDisponibilidade (
    MembroID INT,
    DisponibilidadeID INT,
    PRIMARY KEY (MembroID, DisponibilidadeID),
    FOREIGN KEY (MembroID) REFERENCES Membros (MembroID),
    FOREIGN KEY (DisponibilidadeID) REFERENCES Disponibilidade (DisponibilidadeID)
);

-- Tabela de Relacionamento Membro-Treinamento
CREATE TABLE MembroTreinamento (
    MembroID INT,
    TreinamentoID INT,
    StatusTreinamento ENUM(
        'EmAndamento',
        'Concluído',
        'Desistente'
    ),
    DataConclusao DATE,
    Certificado BOOLEAN DEFAULT FALSE,
    PRIMARY KEY (MembroID, TreinamentoID),
    FOREIGN KEY (MembroID) REFERENCES Membros (MembroID),
    FOREIGN KEY (TreinamentoID) REFERENCES Treinamentos (TreinamentoID)
);

-- Tabela de Eventos/Escalas
CREATE TABLE Eventos (
    EventoID INT PRIMARY KEY AUTO_INCREMENT,
    NomeEvento VARCHAR(100) NOT NULL,
    DataEvento DATETIME,
    Descricao TEXT,
    AreaResponsavel INT,
    FOREIGN KEY (AreaResponsavel) REFERENCES AreasAtuacao (AreaID)
);

-- Tabela de Escala de Voluntários para Eventos
CREATE TABLE EscalaVoluntarios (
    EventoID INT,
    MembroID INT,
    FuncaoEvento VARCHAR(100),
    StatusPresenca ENUM(
        'Confirmado',
        'Pendente',
        'Ausente'
    ),
    PRIMARY KEY (EventoID, MembroID),
    FOREIGN KEY (EventoID) REFERENCES Eventos (EventoID),
    FOREIGN KEY (MembroID) REFERENCES Membros (MembroID)
);