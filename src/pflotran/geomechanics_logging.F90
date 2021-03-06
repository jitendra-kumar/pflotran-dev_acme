module Geomechanics_Logging_module
  
  use PFLOTRAN_Constants_module

! IMPORTANT NOTE: This module can have no dependencies on other modules!!!
 
  implicit none

  private

#include "petsc/finclude/petscsys.h"

! stages
PetscInt, parameter, public :: GEOMECH_INIT_STAGE = 1
PetscInt, parameter, public :: GEOMECH_TS_STAGE = 2
PetscInt, parameter, public :: GEOMECH_SOLVE_STAGE = 3
PetscInt, parameter, public :: GEOMECH_OUTPUT_STAGE = 4

  type, public :: geomech_logging_type 
  
    PetscLogStage :: stage(10)
    
    PetscClassId :: class_pflotran
 
    PetscLogEvent :: event_geomech_condition_read
    PetscLogEvent :: event_geomech_condition_read_values
    PetscLogEvent :: event_geomech_residual
    PetscLogEvent :: event_geomech_jacobian
    PetscLogEvent :: event_output_tecplot
    PetscLogEvent :: event_output_write_tecplot
    PetscLogEvent :: event_output_get_var_from_array
    PetscLogEvent :: event_h5dwrite_f

  end type geomech_logging_type
  
  type(geomech_logging_type), pointer, public :: geomech_logging
  
  public :: GeomechLoggingCreate, &
            GeomechLoggingDestroy

contains

! ************************************************************************** !

subroutine GeomechLoggingCreate()
  ! 
  ! Allocates and initializes a new geomech_logging object
  ! 
  ! Author: Satish Karra, LANL
  ! Date: 06/12/13
  ! 

  implicit none
  
  PetscErrorCode :: ierr
  
  allocate(geomech_logging)

  call PetscLogStageRegister('Geomech Init Stage',  & 
                             geomech_logging%stage(GEOMECH_INIT_STAGE), &
                             ierr);CHKERRQ(ierr)
  call PetscLogStageRegister('Geomech Time Step Stage', &
                             geomech_logging%stage(GEOMECH_TS_STAGE), &
                             ierr);CHKERRQ(ierr)
  call PetscLogStageRegister('Geomech Flow Stage', &
                             geomech_logging%stage(GEOMECH_SOLVE_STAGE), &
                             ierr);CHKERRQ(ierr)
  call PetscLogStageRegister('Geomech Output Stage', &
                             geomech_logging%stage(GEOMECH_OUTPUT_STAGE), &
                             ierr);CHKERRQ(ierr)
                             
  call PetscClassIdRegister('Geomech PFLOTRAN', &
                            geomech_logging%class_pflotran, &
                            ierr);CHKERRQ(ierr)

  call PetscLogEventRegister('GeomechCondRead', &
                             geomech_logging%class_pflotran, &
                             geomech_logging%event_geomech_condition_read, &
                             ierr);CHKERRQ(ierr)
 
  call PetscLogEventRegister('GeomechCondReadVals', &
                        geomech_logging%class_pflotran, &
                        geomech_logging%event_geomech_condition_read_values, &
                        ierr);CHKERRQ(ierr)

  call PetscLogEventRegister('GeomechResidual', &
                             geomech_logging%class_pflotran, &
                             geomech_logging%event_geomech_residual, &
                             ierr);CHKERRQ(ierr)
                            
  call PetscLogEventRegister('GeomechJacobian', &
                             geomech_logging%class_pflotran, &
                             geomech_logging%event_geomech_jacobian, &
                             ierr);CHKERRQ(ierr)
                             
  call PetscLogEventRegister('GeomechOutputTecplot', &
                             geomech_logging%class_pflotran, &
                             geomech_logging%event_output_tecplot, &
                             ierr);CHKERRQ(ierr)
                             
  call PetscLogEventRegister('GeomechOutputWriteTecplot', &
                             geomech_logging%class_pflotran, &
                             geomech_logging%event_output_write_tecplot, &
                             ierr);CHKERRQ(ierr)
  
  call PetscLogEventRegister('GeomechOutputGetVarFromArray', &
                             geomech_logging%class_pflotran, &
                             geomech_logging%event_output_get_var_from_array, &
                             ierr);CHKERRQ(ierr)
                             
  call PetscLogEventRegister('GeomechH5DWrite_F', &
                             geomech_logging%class_pflotran, &
                             geomech_logging%event_h5dwrite_f, &
                             ierr);CHKERRQ(ierr)
                             
end subroutine GeomechLoggingCreate

! ************************************************************************** !

subroutine GeomechLoggingDestroy()
  ! 
  ! OptionDestroy: Deallocates a geomech_logging object
  ! 
  ! Author: Satish Karra, LANL
  ! Date: 06/12/13
  ! 

  implicit none
  
  ! all kinds of stuff needs to be added here.
  
  deallocate(geomech_logging)
  nullify(geomech_logging)
  
end subroutine GeomechLoggingDestroy

end module Geomechanics_Logging_module
