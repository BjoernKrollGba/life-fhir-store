library Retrieve version '1.0'
using FHIR version '4.0.0'
include FHIRHelpers version '4.0.0'

codesystem "ICD-10-GM:2019": 'http://fhir.de/CodeSystem/dimdi/icd-10-gm' version '2019'
code "Weichteilsarkom": 'C49' from "ICD-10-GM:2019"
code "Speicheldrüsenkrebs": 'C08' from "ICD-10-GM:2019"
code "Thrombotische Mikroangiopathie": 'M31.1' from "ICD-10-GM:2019"

context Patient

define Qualifies:
  Exists([Condition: "Weichteilsarkom"]) or
  Exists([Condition: "Speicheldrüsenkrebs"]) or
  Exists([Condition: "Thrombotische Mikroangiopathie"])

context Population

define NumberOfPatients:
  Count(Qualifies Q where Q return all Q)
