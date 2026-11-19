#include "FLUKAIonInelasticPhysics.hh"

#ifdef G4_USE_FLUKA

#  include "FLUKAInelasticScatteringXS.hh"
#  include "FLUKANuclearInelasticModel.hh"
#  include "G4Alpha.hh"
#  include "G4ComponentGGNuclNuclXsc.hh"
#  include "G4Deuteron.hh"
#  include "G4GenericIon.hh"
#  include "G4CrossSectionInelastic.hh"
#  include "G4HadronicInteraction.hh"
#  include "G4HadronInelasticProcess.hh"
#  include "G4He3.hh"
#  include "G4ParticleDefinition.hh"
#  include "G4PhysicsListHelper.hh"
#  include "G4Triton.hh"

namespace
{
void RegisterInelasticProcess(G4ParticleDefinition* particle, const G4String& name,
                              G4PhysicsListHelper* helper,
                              G4VCrossSectionDataSet* crossSection,
                              G4HadronicInteraction* finalStateModel)
{
  auto* process = new G4HadronInelasticProcess(name, particle);
  process->AddDataSet(crossSection);
  process->RegisterMe(finalStateModel);
  helper->RegisterProcess(process, particle);
}
}  // namespace

FLUKAIonInelasticPhysics::FLUKAIonInelasticPhysics()
  : G4VPhysicsConstructor("FLUKA ion inelastic physics")
{}

void FLUKAIonInelasticPhysics::ConstructParticle()
{}

void FLUKAIonInelasticPhysics::ConstructProcess()
{
  auto* helper = G4PhysicsListHelper::GetPhysicsListHelper();
  auto* crossSection = new FLUKAInelasticScatteringXS();
  auto* finalStateModel = new FLUKANuclearInelasticModel();

  RegisterInelasticProcess(G4Deuteron::Deuteron(), "dInelastic", helper,
                           crossSection, finalStateModel);
  RegisterInelasticProcess(G4Triton::Triton(), "tInelastic", helper,
                           crossSection, finalStateModel);
  RegisterInelasticProcess(G4He3::He3(), "He3Inelastic", helper,
                           crossSection, finalStateModel);
  RegisterInelasticProcess(G4Alpha::Alpha(), "alphaInelastic", helper,
                           crossSection, finalStateModel);

  // The FLUKA XS adapter cannot build its physics table against the dummy
  // GenericIon definition (Z=A=0). Actual ion tracks still use FLUKA final
  // states; retain Geant4's ion-nucleus XS for this catch-all process.
  auto* genericIonCrossSection =
    new G4CrossSectionInelastic(new G4ComponentGGNuclNuclXsc());
  RegisterInelasticProcess(G4GenericIon::GenericIon(), "ionInelastic", helper,
                           genericIonCrossSection, finalStateModel);
}

#else

FLUKAIonInelasticPhysics::FLUKAIonInelasticPhysics()
  : G4VPhysicsConstructor("FLUKA ion inelastic physics")
{}

void FLUKAIonInelasticPhysics::ConstructParticle()
{}

void FLUKAIonInelasticPhysics::ConstructProcess()
{}

#endif
