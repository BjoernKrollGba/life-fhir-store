(ns life-fhir-store.cql-translator-test
  (:require
    [clojure.test :refer :all]
    [juxt.iota :refer [given]]
    [life-fhir-store.cql-translator :refer [translate]]))


(defmacro given-translation [cql & body]
  `(given (-> (translate ~cql) :statements :def) ~@body))


(deftest translate-test
  (testing "Simple Retrieve"
    (given-translation
      "library Test
        using FHIR version '3.0.0'
        define Patients: [Patient]"
      [0 :expression :type] := "Retrieve"
      [0 :expression :dataType] := "{http://hl7.org/fhir}Patient"))

  (testing "Retrieve with Code"
    (given-translation
      "library Test
        using FHIR version '3.0.0'
        codesystem test: 'test'
        code T0: '0' from test
        define Observations: [Observation: T0]"
      [0 :expression :type] := "Retrieve"
      [0 :expression :dataType] := "{http://hl7.org/fhir}Observation"
      [0 :expression :codes :type] := "ToList"
      [0 :expression :codes :operand :type] := "CodeRef"
      [0 :expression :codes :operand :name] := "T0")))
