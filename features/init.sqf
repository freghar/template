#include "..\include\common.h"

#ifdef FEAT_HIDE_BODY
call {
#include "Hide_Body\init.sqf"
};
#endif

#ifdef FEAT_ARSENAL_RESPAWN
call {
#include "Arsenal_Respawn\init.sqf"
};
#endif

#ifdef FEAT_ARES_EXTRAS
call {
#include "Ares_Extras\init.sqf"
};
#endif

#ifdef FEAT_AI2SERVER
call {
#include "AI2Server\init.sqf"
};
#endif
