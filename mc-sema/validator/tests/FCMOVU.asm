BITS 32
;TEST_FILE_META_BEGIN
;TEST_TYPE=TEST_F
;TEST_IGNOREFLAGS=
;TEST_FILE_META_END
    FLDPI
    FLD1
    ;SET PF
    MOV EAX, 0x3
    CMP EAX, 0
    ;TEST_BEGIN_RECORDING
    fcmovu st0, st1
    ;TEST_END_RECORDING

