CREATE TABLE Acerto (
    IDAcerto    INTEGER         NOT NULL
                                UNIQUE
                                PRIMARY KEY,
    IDCliente   INTEGER         NOT NULL
                                REFERENCES Cliente (IDCliente),
    SaldoAcerto NUMERIC (10, 2) NOT NULL
                                DEFAULT (0),
    Status      VARCHAR (9)     NOT NULL
                                DEFAULT Ativo
);

CREATE TABLE CafeEmprestado (
    IDCafeEmprestado INTEGER         PRIMARY KEY
                                     UNIQUE
                                     NOT NULL,
    IDLoteLimpo      INTEGER         REFERENCES LoteLimpo (IDLoteLimpo),
    IDCliente        INTEGER         NOT NULL
                                     REFERENCES Cliente (IDCliente),
    Data             DATE            NOT NULL,
    Historico        VARCHAR (30),
    PesoEmprestar    NUMERIC (10, 3),
    PesoDevolver     NUMERIC (10, 3),
    Status           VARCHAR (9) 
);

CREATE TABLE Cliente (
    IDCliente            INTEGER         PRIMARY KEY
                                         UNIQUE
                                         NOT NULL,
    Serie                CHAR (9),
    IDPrincipal          INTEGER,
    DataReg              DATE,
    Razao                VARCHAR (40),
    CPF                  CHAR (11),
    CNPJ                 CHAR (14),
    Endereco             VARCHAR (40),
    InsEstadual          CHAR (12),
    Complemento          VARCHAR (40),
    Bairro               VARCHAR (40),
    Cidade               VARCHAR (40),
    Estado               VARCHAR (20),
    Telefone             CHAR (11),
    Celular              CHAR (12),
    Obs                  TEXT,
    SaldoSacariaPlastico INTEGER         NOT NULL
                                         DEFAULT (0),
    SaldoSacariaJuta     INTEGER         NOT NULL
                                         DEFAULT (0),
    SaldoCafeEmprestado  NUMERIC (10, 3) NOT NULL
                                         DEFAULT (0),
    SaldoContaCorrente   NUMERIC (10, 2) NOT NULL
                                         DEFAULT (0),
    Status               VARCHAR (9) 
);

CREATE TABLE ContaCorrente (
    IDContaCorrente INTEGER         PRIMARY KEY
                                    UNIQUE
                                    NOT NULL
                                    DEFAULT (0),
    IDAcerto        INTEGER         REFERENCES Acerto (IDAcerto) 
                                    NOT NULL
                                    DEFAULT (0),
    IDCliente       INTEGER         REFERENCES Cliente (IDCliente) 
                                    NOT NULL,
    Data            DATE (10)       NOT NULL,
    Historico       VARCHAR (20),
    Entrada         NUMERIC (10, 2) NOT NULL
                                    DEFAULT (0),
    Saida           NUMERIC (10, 2) NOT NULL
                                    DEFAULT (0),
    Status          VARCHAR (9)     NOT NULL
                                    DEFAULT ativo
);

CREATE TABLE EstoqueDepositoCoco (
    IDEstoqueDepositoCoco INTEGER      PRIMARY KEY
                                       NOT NULL,
    IDRomEntradaCoco      INTEGER      NOT NULL,
    PesoEntrada           NUMERIC (10) NOT NULL,
    PesoSaida             NUMERIC (10) NOT NULL,
    Saldo                 NUMERIC      NOT NULL,
    Status                VARCHAR (7)  NOT NULL
);

CREATE TABLE LoteCoco (
    IDLoteCoco   INTEGER         PRIMARY KEY
                                 UNIQUE
                                 NOT NULL,
    NomeLoteCoco VARCHAR (30)    NOT NULL,
    Safra        CHAR (4)        NOT NULL,
    Tulha        VARCHAR (10)    NOT NULL,
    CafeBom      NUMERIC (10, 3) DEFAULT (0) 
                                 NOT NULL,
    Bica         NUMERIC (10, 3) DEFAULT (0) 
                                 NOT NULL,
    Escolha      NUMERIC (10, 3) DEFAULT (0) 
                                 NOT NULL,
    Obs          VARCHAR (30),
    Status       VARCHAR (9)     DEFAULT Ativo
                                 NOT NULL
);

CREATE TABLE LoteLimpo (
    IDLoteLimpo INTEGER         PRIMARY KEY
                                NOT NULL
                                UNIQUE,
    Nome        VARCHAR (30)    NOT NULL,
    Saldo       NUMERIC (10, 3) DEFAULT (0) 
                                NOT NULL,
    Status      CHAR (9)        DEFAULT Ativo
                                NOT NULL
);

CREATE TABLE LoteSacaria (
    IDLoteSacaria INTEGER      PRIMARY KEY
                               UNIQUE
                               NOT NULL,
    Nome          VARCHAR (30) NOT NULL,
    Saldo         INTEGER      NOT NULL,
    Status        CHAR (9) 
);

CREATE TABLE MovLoteCoco (
    IDMovLoteCoco    INTEGER      PRIMARY KEY
                                  UNIQUE
                                  NOT NULL
                                  DEFAULT (0),
    IDLoteCoco       INTEGER      NOT NULL
                                  REFERENCES LoteCoco (IDLoteCoco) 
                                  DEFAULT (0),
    IDRomEntradaCoco INTEGER      NOT NULL
                                  DEFAULT (0),
    IDRomSaidaCoco   INTEGER      NOT NULL
                                  DEFAULT (0),
    IDCliente        INTEGER      NOT NULL
                                  DEFAULT (0),
    Data             DATE,
    Historico        VARCHAR (30),
    PesoCocoEntrada  NUMERIC (10) NOT NULL
                                  DEFAULT (0),
    PesoCocoSaida    NUMERIC (10) NOT NULL
                                  DEFAULT (0),
    Status           VARCHAR (9)  NOT NULL
                                  DEFAULT Ativo
);

CREATE TABLE MovLoteLimpo (
    IDMovLoteLimpo INTEGER         PRIMARY KEY
                                   NOT NULL
                                   UNIQUE,
    IDLoteLimpo    INTEGER         REFERENCES LoteLimpo (IDLoteLimpo) 
                                   NOT NULL,
    IDCliente      INTEGER         NOT NULL
                                   REFERENCES Cliente (IDCliente),
    Data           DATE            NOT NULL,
    Historico      VARCHAR (30)    NOT NULL,
    PesoEntrada    NUMERIC (10, 3) NOT NULL
                                   DEFAULT (0),
    PesoSaida      NUMERIC (10, 3) NOT NULL
                                   DEFAULT (0),
    Status         VARCHAR (9)     NOT NULL
);


CREATE TABLE MovLoteSacaria (
    IDMovLoteSacaria INTEGER      PRIMARY KEY
                                  NOT NULL
                                  UNIQUE,
    IDLoteSacaria    INTEGER      REFERENCES LoteLimpo (IDLoteLimpo) 
                                  NOT NULL,
    IDCliente        INTEGER      NOT NULL
                                  REFERENCES Cliente (IDCliente),
    Data             DATE         NOT NULL,
    Historico        VARCHAR (30) NOT NULL,
    QuanEntrada      INTEGER      NOT NULL
                                  DEFAULT (0),
    QuanSaida        INTEGER      NOT NULL
                                  DEFAULT (0),
    Status           VARCHAR (9)  NOT NULL
);

CREATE TABLE RomCompraCoco (
    IDRomCompraCoco  INTEGER      UNIQUE
                                  PRIMARY KEY
                                  NOT NULL,
    IDRomEntradaCoco INTEGER,
    Data             DATE,
    Historico        VARCHAR (20),
    PesoCoco         NUMERIC (10),
    SacoKg           VARCHAR (4),
    PorcFundoRural   NUMERIC (10),
    Aliquota         NUMERIC (10),
    Valor            REAL (10, 2),
    IDContaCorrente  INTEGER (10),
    Status           VARCHAR (7) 
);

CREATE TABLE RomEntradaCoco (
    IDRomEntradaCoco INTEGER         PRIMARY KEY
                                     UNIQUE
                                     NOT NULL,
    IDCliente        INTEGER         REFERENCES Cliente (IDCliente),
    Data             DATE,
    Renda            NUMERIC (10),
    PesoBruto        NUMERIC (10),
    Impureza         NUMERIC (10),
    QuanPlastico     NUMERIC (10),
    PesoPlastico     NUMERIC (10),
    QuanJuta         NUMERIC (10),
    PesoJuta         NUMERIC (10),
    Legenda1         VARCHAR (20),
    Desconto1        NUMERIC (10),
    Porcentagem      NUMERIC (10),
    BeberLimpo       NUMERIC (10, 3),
    BeberCoco        NUMERIC (10),
    Legenda2         VARCHAR (20),
    Desconto2        NUMERIC (10),
    IDLoteCoco       INTEGER (10),
    Obs              VARCHAR (30),
    PesoDepositado   INTEGER (10),
    IDRomCompraCoco  INTEGER (10)    NOT NULL,
    Status           VARCHAR (7)     NOT NULL
);

INSERT INTO Cliente ( IDCliente, IDPrincipal, Serie, DataReg, Razao, Endereco)
VALUES (0, 0, 'Adicional', '0000-00-00','Nenhum', 'Nenhum');
INSERT INTO LoteLimpo ( IDLoteLimpo, Nome, Saldo, Status)
VALUES (1, 'Cafe para beber Padrão', 0,'Protegido');
INSERT INTO LoteLimpo ( IDLoteLimpo, Nome, Saldo, Status)
VALUES (2, 'Cafe Bom Padrão', 0,'Protegido');
INSERT INTO LoteLimpo ( IDLoteLimpo, Nome, Saldo, Status)
VALUES (3, 'Bica Padrão', 0,'Protegido');
INSERT INTO LoteLimpo ( IDLoteLimpo, Nome, Saldo, Status)
VALUES (4, 'Escolha Padrão', 0,'Protegido');
INSERT INTO LoteSacaria ( IDLoteSacaria, Nome, Saldo, Status)
VALUES (0, 'Nenhum', 0,'Protegido');
INSERT INTO LoteSacaria ( IDLoteSacaria, Nome, Saldo, Status)
VALUES (1, 'Sacaria de plástico', 0,'Protegido');
INSERT INTO LoteSacaria ( IDLoteSacaria, Nome, Saldo, Status)
VALUES (2, 'Sacaria de juta', 0,'Protegido');
INSERT INTO Acerto ( IDAcerto, IDCliente, SaldoAcerto, Status)
VALUES (0, 0, 0,'Protegido');
INSERT INTO RomCompraCoco ( IDRomCompraCoco, IDRomEntradaCoco, PesoCoco, Status)
VALUES (0, 0, 0,'Protegido');
INSERT INTO RomEntradaCoco ( IDRomEntradaCoco, IDRomCompraCoco, Status)
VALUES (0, 0, 'Protegido');