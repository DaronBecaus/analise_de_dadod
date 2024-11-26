-- Tabela de Pastores de Área
CREATE TABLE PastoresArea (
    PastorID INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(100) NOT NULL,
    Telefone VARCHAR(20),
    Email VARCHAR(100)
);

-- Tabela de Áreas Eclesiásticas
CREATE TABLE AreasEclesiasticas (
    AreaID INT PRIMARY KEY AUTO_INCREMENT,
    NumeroArea INT NOT NULL,
    Endereco VARCHAR(255),
    PastorResponsavelID INT,
    FOREIGN KEY (PastorResponsavelID) REFERENCES PastoresArea (PastorID)
);

-- Tabela de Membros/Voluntários
CREATE TABLE Membros (
    MembroID INT PRIMARY KEY AUTO_INCREMENT,
    NomeCompleto VARCHAR(150) NOT NULL,
    DataNascimento DATE,
    Genero ENUM('Masculino', 'Feminino'),
    Telefone VARCHAR(20),
    EnderecoResidencial VARCHAR(255),
    Email VARCHAR(100),
    AreaEclesiasticaID INT,
    NivelEducacao ENUM(
        'Ensino Fundamental',
        'Ensino Médio',
        'Ensino Técnico',
        'Ensino Superior (Graduação)',
        'Pós-Graduação'
    ),
    AreaEstudo VARCHAR(100),
    FOREIGN KEY (AreaEclesiasticaID) REFERENCES AreasEclesiasticas (AreaID)
);

-- Tabela de Funções Ministeriais
CREATE TABLE FuncoesMinisteriais (
    FuncaoID INT PRIMARY KEY AUTO_INCREMENT,
    NomeFuncao VARCHAR(100) NOT NULL
);

-- Tabela de Relacionamento Membros e Funções
CREATE TABLE MembroFuncoes (
    MembroID INT,
    FuncaoID INT,
    PRIMARY KEY (MembroID, FuncaoID),
    FOREIGN KEY (MembroID) REFERENCES Membros (MembroID),
    FOREIGN KEY (FuncaoID) REFERENCES FuncoesMinisteriais (FuncaoID)
);

-- Tabela de Habilidades de Comunicação e Multimídia
CREATE TABLE HabilidadesComunicacao (
    HabilidadeID INT PRIMARY KEY AUTO_INCREMENT,
    NomeHabilidade VARCHAR(100) NOT NULL
);

-- Tabela de Relacionamento Membros e Habilidades
CREATE TABLE MembroHabilidades (
    MembroID INT,
    HabilidadeID INT,
    NivelProficiencia ENUM(
        'Iniciante',
        'Intermediário',
        'Avançado'
    ),
    PRIMARY KEY (MembroID, HabilidadeID),
    FOREIGN KEY (MembroID) REFERENCES Membros (MembroID),
    FOREIGN KEY (HabilidadeID) REFERENCES HabilidadesComunicacao (HabilidadeID)
);

-- Tabela de Experiência Prévia em Mídia
CREATE TABLE ExperienciaMidia (
    ExperienciaID INT PRIMARY KEY AUTO_INCREMENT,
    MembroID INT,
    Descricao TEXT,
    DataInicio DATE,
    DataTermino DATE,
    FOREIGN KEY (MembroID) REFERENCES Membros (MembroID)
);

-- Tabela de Motivação para Voluntariado
CREATE TABLE MotivacaoVoluntariado (
    MotivacaoID INT PRIMARY KEY AUTO_INCREMENT,
    MembroID INT,
    Descricao TEXT,
    FOREIGN KEY (MembroID) REFERENCES Membros (MembroID)
);

-- Tabela de Visão para Ministério de Comunicação
CREATE TABLE VisaoMinisterioComunicacao (
    VisaoID INT PRIMARY KEY AUTO_INCREMENT,
    MembroID INT,
    Descricao TEXT,
    Objetivos TEXT,
    FOREIGN KEY (MembroID) REFERENCES Membros (MembroID)
);

-- Tabela de Contexto de Mídia na Congregação
CREATE TABLE ContextoMidiaCongregacao (
    ContextoID INT PRIMARY KEY AUTO_INCREMENT,
    MembroID INT,
    NumeroEquipe INT,
    Dificuldades TEXT,
    RecursosDisponiveis TEXT,
    EstruturaMidiática TEXT,
    FOREIGN KEY (MembroID) REFERENCES Membros (MembroID)
);

-- Inserção de Funções Ministeriais Padrão
INSERT INTO
    FuncoesMinisteriais (NomeFuncao)
VALUES ('Professor EBD'),
    ('Mídia'),
    ('Recepção'),
    ('Regente'),
    ('Coordenador de Jovens'),
    ('Sonoplasta'),
    ('Líder de Comunicação'),
    ('Músico'),
    ('Cantor');

-- Inserção de Habilidades de Comunicação
INSERT INTO
    HabilidadesComunicacao (NomeHabilidade)
VALUES ('Fotografia'),
    ('Edição de Vídeo'),
    ('Edição de Fotos'),
    ('Redação'),
    ('Mídias Sociais'),
    ('Transmissão ao Vivo'),
    ('Design Gráfico'),
    ('Projeção'),
    ('Copywriting');