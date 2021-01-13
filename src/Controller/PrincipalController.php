<?php


namespace App\Controller {


    use App\Entity\Schoolclass;
    use App\Entity\User;
    use Symfony\Component\HttpFoundation\Request;
    use Symfony\Component\HttpFoundation\Response;
    use Symfony\Component\Routing\Annotation\Route;

    class PrincipalController extends BaseController
    {

        /**
         * @param array $users
         * @param string $type
         * @return Response
         */
        private function show(array $users,string $type): Response
        {
            $classes = $this->getDoctrine()->getRepository(Schoolclass::class)->findAll();
            return $this->render('principal/default.html.twig',
                ['teachers' => $users,
                    'classes' => $classes,
                    'type'=>$type
                ]);
        }
        /**
         * @Route("/principal" , name="principal_home")
         */
        public function defaultAction():Response{
            $teachers = $this->getDoctrine()->getRepository(User::class)->findTeachers();
            return $this->show($teachers,"DOCENTEN");
        }

        /**
         * @Route("/principal/teachers" , name="principal_teachers")
         */
        public function showTeachersAction():Response{
            $teachers = $this->getDoctrine()->getRepository(User::class)->findTeachers();
            return $this->show($teachers,"DOCENTEN");
        }

        /**
         * @Route("/principal/admins" , name="principal_admins")
         */
        public function showAdminsAction():Response{
            $admins = $this->getDoctrine()->getRepository(User::class)->findAdministrators();
            return $this->show($admins,"ADMINISTRATIE");
        }

        /**
         * Route("/principal/update/user/{id}",  name="principal_update_user", requirements={"id"="\d+"})
         * @param Request $request
         * @param int $id
         * @return Response
         */
        public function principalUpdateUserAction(Request $request, int $id):Response{
            //TODO
        }

        /**
         * Route("/principal/reset/user/{id}",  name="principal_reset_user", requirements={"id"="\d+"})
         * @param Request $request
         * @param int $id
         * @return Response
         */
        public function principalResetUserAction(Request $request, int $id):Response{
            //TODO
        }

        /**
         * Route("/principal/delete/user/{id}",  name="principal_delete_user", requirements={"id"="\d+"})
         * @param Request $request
         * @param int $id
         * @return Response
         */
        public function principalDeleteUserAction(Request $request, int $id):Response{
            //TODO
        }




    }
}