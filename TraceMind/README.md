This is a trace of different security incidents which I would employ to better understand these incidents to a surreal length. Dey with me mate.

The below is what this repository should look like

tracemind/
│
├── README.md
├── requirements.txt
├── .gitignore
│
├── docs/
│   ├── architecture.md
│   ├── data-flow.md
│   ├── assumptions.md
│   ├── threat-model.md
│
├── data/
│   ├── raw/
│   │   ├── synthetic/
│   │   │   └── incident-001.txt
│   │   └── real/
│   │       └── auth-log-001.txt
│   │
│   ├── processed/
│   │   └── incident-001.json
│   │
│   └── samples/
│       └── clean-example.txt
│
├── cases/
│   ├── incident-001-auth-failure/
│   │   ├── scenario.md
│   │   ├── hypothesis.md
│   │   ├── findings.md
│   │   └── conclusion.md
│
├── src/
│   ├── parser/
│   │   └── parser.py
│   │
│   ├── timeline/
│   │   └── timeline.py
│   │
│   ├── analyzer/
│   │   └── analyzer.py
│   │
│   ├── models/
│   │   └── event_model.py
│   │
│   └── utils/
│       └── helpers.py
│
├── pipelines/
│   └── incident_pipeline.py
│
├── outputs/
│   ├── reports/
│   │   └── incident-001-report.md
│   │
│   └── timelines/
│       └── incident-001-timeline.json
│
├── tests/
│   ├── test_parser.py
│   ├── test_timeline.py
│   └── test_analyzer.py
│
└── scripts/
    ├── ingest_logs.sh
    └── simulate_events.sh





A whole lot of folders, but don't worry, you wouldn't have to go through everything if you just read the reports
