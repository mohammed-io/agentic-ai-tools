# Medical Diagnosis Plugin

**⚠️ IMPORTANT WARNING - READ CAREFULLY BEFORE USE ⚠️**

## CRITICAL MEDICAL DISCLAIMER

**THIS PLUGIN IS A CLINICAL DECISION SUPPORT TOOL FOR QUALIFIED HEALTHCARE PROFESSIONALS ONLY**

This tool is designed to **supplement (not replace)** clinical judgment and should only be used by qualified healthcare professionals. The following points are absolutely critical:

- **FOR HEALTHCARE PROFESSIONALS ONLY:** This tool is intended for use by physicians, nurse practitioners, and other qualified medical professionals as a decision support aid
- **SUPPLEMENTS CLINICAL JUDGMENT:** This AI system assists in organizing diagnostic reasoning but **never replaces** your clinical expertise, physical examination, or professional judgment
- **NOT FOR EMERGENCIES:** This tool is not designed for emergency situations. Emergency care requires immediate clinical assessment and intervention
- **LIMITATIONS:** AI systems make errors and can provide incomplete or incorrect information. All AI-generated suggestions must be **verified through clinical practice**
- **NO TREATMENT PRESCRIPTIONS:** This tool does not provide treatment recommendations or prescribe medications. All treatment decisions remain the sole responsibility of the treating clinician

## LIABILITY DISCLAIMER

**NO LIABILITY OF ANY KIND**

The author, developers, and contributors of this plugin assume **NO LIABILITY** of any kind, including but not limited to:

- Any patient harm or adverse outcomes resulting from clinical use of this tool
- Medical decisions made based on information provided by this plugin
- Inaccurate, incomplete, or misleading information provided
- Any consequences of using this information in clinical practice
- Malpractice claims or legal actions resulting from use of this tool

**BY USING THIS PLUGIN, YOU AGREE THAT:**

- You are a **qualified healthcare professional** using this as a decision support aid only
- This tool **supplements but never replaces** your clinical judgment and expertise
- You remain **solely responsible** for all medical decisions and patient care
- The author is not responsible for any clinical outcomes resulting from use of this plugin
- AI limitations are understood and all AI-generated information is **verified through clinical practice**

## Purpose of This Plugin

This plugin is designed to:

- **Support clinical decision-making** for physicians by providing structured diagnostic frameworks
- Assist doctors in **systematically gathering patient information** through evidence-based interview protocols
- Provide **specialty-specific medical knowledge** across 20+ medical fields
- Help **organize differential diagnoses** and consider relevant conditions based on presenting symptoms
- Serve as a **clinical decision support tool** for qualified healthcare professionals

## How It Works

This plugin provides access to:

- **Diagnostic Assistant Command** (`doctor-diagnose-assistant`): An interactive assistant that asks structured questions about symptoms and medical history
- **Specialty Agents**: Medical specialists covering 20+ medical fields who can provide targeted guidance

### Available Medical Specialties

The `agents/` directory contains specialty-specific guidance for:

- **General Medicine** - Primary diagnostic coordinator
- **Cardiology** - Heart conditions, chest pain, arrhythmias
- **Pulmonology** - Respiratory conditions, asthma, COPD
- **Gastroenterology** - Digestive system, liver disease
- **Neurology** - Brain, nervous system, stroke, seizures
- **Nephrology** - Kidney function, electrolytes
- **Endocrinology** - Diabetes, thyroid, hormones
- **Infectious Disease** - Infections, sepsis, fever
- **Hematology/Oncology** - Blood disorders, cancer
- **Psychiatry** - Mental health conditions
- **Clinical Psychology** - Mental health support
- **Emergency Medicine** - Critical care, trauma, resuscitation
- **Surgery** - Surgical conditions, acute abdomen
- **Pediatrics** - Medical care for children
- **OB/GYN** - Pregnancy, women's health
- **Geriatrics** - Elderly care
- **Dermatology** - Skin conditions
- **Urology** - Urinary system
- **Rheumatology** - Autoimmune conditions
- **Pharmacology** - Medication information

## Usage

### For Clinical Decision Support (Intended Use Case)

This tool is designed to assist physicians in their clinical practice:

1. Use the diagnostic assistant to systematically structure patient interviews
2. Leverage specialty agents for domain-specific diagnostic insights
3. Generate comprehensive differential diagnoses based on presenting symptoms
4. Access evidence-based medical knowledge across multiple specialties
5. Support clinical reasoning with structured medical frameworks

### Command

```bash
/doctor-diagnose-assistant [patient presentation]
```

## What This Plugin CANNOT Do

- Perform physical examinations or obtain vital signs
- Order or interpret lab tests and imaging studies
- Replace clinical judgment or medical expertise
- Make definitive diagnoses or treatment decisions
- Account for patient-specific contextual factors that you would assess in person
- Be held liable for any clinical outcomes

**The treating clinician remains solely responsible for all patient care decisions.**

## Clinical Context and Limitations

**REQUIRE IN-PERSON ASSESSMENT** for:

- Any condition requiring physical examination
- Patients with abnormal vital signs
- Symptoms requiring diagnostic imaging or laboratory studies
- Complex multisystem presentations
- Patients with significant comorbidities

**USE WITH CAUTION** for:

- Pediatric patients (requires specialized knowledge)
- Geriatric patients (atypical presentations common)
- Pregnant patients
- Patients with multiple chronic conditions
- Patients on complex medication regimens

## Developer Notes

This plugin follows strict medical safety protocols:

- **NEVER ASSUMES - ALWAYS ASKS**: The system never makes assumptions about symptoms or conditions
- **Systematic Questioning**: Follows evidence-based medical interview protocols (OPQRST, ROS, etc.)
- **Red Flag Screening**: Always screens for potentially life-threatening conditions
- **Specialist Coordination**: Consults specialty agents when appropriate
- **Uncertainty Qualification**: Explicitly states limitations and missing information

## Ethical Use

This plugin should only be used:

- By **qualified healthcare professionals** as a clinical decision support aid
- To **supplement (not replace)** clinical judgment and expertise
- For **organizing diagnostic reasoning** and considering differential diagnoses
- With understanding that **AI systems have limitations** and can provide incomplete information

This plugin should NOT be used:

- By non-physicians to diagnose or treat themselves or others
- As a substitute for professional medical training and expertise
- To make definitive medical decisions without clinical verification
- In emergency situations requiring immediate clinical intervention
- As the sole basis for medical treatment decisions

## Acknowledgments

By using this plugin, you acknowledge that:

- You are a **qualified healthcare professional** (physician, nurse practitioner, or equivalent)
- You have read and understood all warnings and disclaimers
- This tool serves as **clinical decision support only** and never replaces your professional judgment
- The author assumes no liability for any clinical outcomes resulting from use of this tool
- All medical decisions remain your **sole professional responsibility**

---

**Remember: This tool is designed to support clinical decision-making for qualified healthcare professionals. It supplements but never replaces your medical expertise and clinical judgment.**