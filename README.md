# Agentic AI Tools

Claude Code plugins and skills for AI-assisted development workflow automation.

## Overview

Focused plugins with progressive disclosure—skills load knowledge only when activated, keeping context minimal.

## Quick Start

### Step 1: Add the Marketplace

```bash
/plugin marketplace add mohammed-io/agentic-ai-tools
```

### Step 2: Install Plugins

```bash
/plugin install dev-workflow
```

## Available Plugins

### Dev Workflow

Development workflow skills including work tracking and task management.

**Skills included:**
- **Work Tracking** - Enforces mandatory work tracking before code changes with progressive todo updates and crash recovery

### Medical Diagnosis

Medical decision support system with specialty-specific guidance for informational purposes only. NOT a replacement for professional medical care.

**⚠️ IMPORTANT:** This plugin is for educational and informational use only. It helps prepare information before consulting healthcare professionals. Always seek professional medical advice for diagnosis and treatment.

**Skills included:**
- **Doctor Diagnose Assistant** - Interactive assistant that systematically gathers patient information through structured questioning, provides differential diagnoses, and coordinates specialist consultations across 20+ medical specialties

**Medical Specialties:**
Cardiology, Pulmonology, Gastroenterology, Neurology, Nephrology, Endocrinology, Infectious Disease, Hematology/Oncology, Psychiatry, Clinical Psychology, Emergency Medicine, Surgery, Pediatrics, OB/GYN, Geriatrics, Dermatology, Urology, Rheumatology, Pharmacology

## Repository Structure

```
agentic-ai-tools/
├── .claude-plugin/
│   └── marketplace.json          # Plugin manifest
├── plugins/
│   ├── dev-workflow/
│   │   └── skills/
│   │       └── work-tracking/
│   │           ├── README.md
│   │           ├── SKILL.md
│   │           └── scaffold/
│   │           ├── bin/
│   │           └── ...
│   └── medical-diagnosis/
│       ├── agents/               # Medical specialty agents
│       ├── commands/             # Diagnostic commands
│       └── README.md
└── README.md
```

## License

MIT
