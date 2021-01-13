<?php

namespace App\Entity {

    use App\Repository\UserRepository;
    use Doctrine\Common\Collections\ArrayCollection;
    use Doctrine\Common\Collections\Collection;
    use Doctrine\ORM\Mapping as ORM;
    use Symfony\Component\Security\Core\User\UserInterface;

    /**
     * @ORM\Entity(repositoryClass=UserRepository::class)
     * @ORM\Table(name="users")
     */
    class User implements UserInterface
    {
        private const IMAGE_PATH = 'img/';
        /**
         * @ORM\Id
         * @ORM\GeneratedValue
         * @ORM\Column(type="integer")
         */
        private $id;

        /**
         * @ORM\Column(type="string", length=180, unique=true)
         */
        private $email;

        /**
         * @ORM\Column(type="json")
         */
        private array $roles = [];

        /**
         * @var string The hashed password
         * @ORM\Column(type="string")
         */
        private $password;

        /**
         * @ORM\Column(type="string", length=50, nullable=false)
         */
        private  $firstname;

        /**
         * @ORM\Column(type="string", length=20, nullable=true)
         */
        private $prefix;

        /**
         * @ORM\Column(type="string", length=50)
         */
        private $lastname;

        /**
         * @ORM\Column(type="string", length=50, nullable=true)
         */
        private $photo;

        /**
         * @ORM\ManyToOne(targetEntity=Schoolclass::class, inversedBy="users")
         */
        private $schoolclass;
        /**
         * one mentor has one class
         * @ORM\OneToOne(targetEntity=Schoolclass::class, mappedBy="mentor")
         */
        private $mentorclass;

        /**
         * @ORM\Column(type="text", nullable=true)
         */
        private $motto;

        /**
         * @ORM\OneToMany(targetEntity=StudentRemark::class, mappedBy="author", orphanRemoval=true)
         * represents the remarks as a collection made by the author
         */
        private $remarksAsAuthor;

        /**
         * @ORM\OneToMany(targetEntity=StudentRemark::class, mappedBy="student", orphanRemoval=true)
         * represents the remarks as a collection made for the student
         */
        private $remarksForStudent;

        public function __construct()
        {
            if(in_array("ROLE_STUDENT", $this->roles)) {
                $this->remarksForStudent = new ArrayCollection();
            }
            else {
                $this->remarksAsAuthor = new ArrayCollection();
            }
        }

        public function getId(): ?int
        {
            return $this->id;
        }

        public function getEmail(): ?string
        {
            return $this->email;
        }

        public function setEmail(string $email): self
        {
            $this->email = $email;

            return $this;
        }

        /**
         * A visual identifier that represents this user.
         *
         * @see UserInterface
         */
        public function getUsername(): string
        {
            return (string) $this->email;
        }

        /**
         * @see UserInterface
         */
        public function getRoles(): array
        {
            $roles = $this->roles;
            // guarantee every user at least has ROLE_USER
            $roles[] = 'ROLE_USER';

            return array_unique($roles);
        }

        public function setRoles(array $roles): self
        {
            $this->roles = $roles;

            return $this;
        }

        /**
         * @see UserInterface
         */
        public function getPassword(): string
        {
            return (string) $this->password;
        }

        public function setPassword(string $password): self
        {
            $this->password = $password;

            return $this;
        }

        /**
         * @see UserInterface
         */
        public function getSalt()
        {
            // not needed when using the "bcrypt" algorithm in security.yaml
        }

        /**
         * @see UserInterface
         */
        public function eraseCredentials()
        {
            // If you store any temporary, sensitive data on the user, clear it here
            // $this->plainPassword = null;
        }

        public function getFirstname(): ?string
        {
            return $this->firstname;
        }

        public function setFirstname(string $firstname): self
        {
            $this->firstname = $firstname;

            return $this;
        }

        public function getPrefix(): ?string
        {
            return $this->prefix;
        }

        public function setPrefix(?string $prefix): self
        {
            $this->prefix = $prefix;

            return $this;
        }

        public function getLastname(): ?string
        {
            return $this->lastname;
        }

        public function setLastname(string $lastname): self
        {
            $this->lastname = $lastname;

            return $this;
        }

        public function getPhoto(): ?string
        {
            $value = $this->photo??"nn.jpg";
            return self::IMAGE_PATH.$value;
        }

        public function getPhotoFileName():?string{
            return $this->photo;
        }

        public function setPhoto(?string $photo): self
        {
            $this->photo = $photo;

            return $this;
        }

        public function getSchoolclass(): ?Schoolclass
        {
            return $this->schoolclass;
        }

        public function setSchoolclass(?Schoolclass $schoolclass): self
        {
            $this->schoolclass = $schoolclass;

            return $this;
        }

        public function getMentorclass(): ?Schoolclass
        {
            return $this->mentorclass;
        }

        public function setMentorclass(?Schoolclass $mentorclass): self
        {
            $this->mentorclass = $mentorclass;

            return $this;
        }
        public function getFullName():string
        {
            $prefix = $this->prefix?:"";
            return "$this->firstname $prefix $this->lastname";
        }

        public function getMotto(): ?string
        {
            return $this->motto;
        }

        public function setMotto(?string $motto): self
        {
            $this->motto = $motto;

            return $this;
        }

        /**
         * @return Collection|StudentRemark[]
         */
        public function getRemarksAsAuthor(): Collection
        {
            return $this->remarksAsAuthor;
        }

        public function addRemarkAsAuthor(StudentRemark $remarkByMe): self
        {
            if (!$this->remarksAsAuthor->contains($remarkByMe)) {
                $this->remarksAsAuthor[] = $remarkByMe;
                $remarkByMe->setAuthor($this);
            }

            return $this;
        }

        public function removeRemarkAsAuthor(StudentRemark $remarkByMe): self
        {
            if ($this->remarksAsAuthor->removeElement($remarkByMe)) {
                // set the owning side to null (unless already changed)
                if ($remarkByMe->getAuthor() === $this) {
                    $remarkByMe->setAuthor(null);
                }
            }

            return $this;
        }

        /**
         * @return Collection|StudentRemark[]
         */
        public function getRemarksForStudent(): Collection
        {
            return $this->remarksForStudent;
        }

        public function addRemarkForStudent(StudentRemark $remarkForMe): self
        {
            if (!$this->remarksForStudent->contains($remarkForMe)) {
                $this->remarksForStudent[] = $remarkForMe;
                $remarkForMe->setStudent($this);
            }

            return $this;
        }

        public function removeRemarkForStudent(StudentRemark $remarkForMe): self
        {
            if ($this->remarksForStudent->removeElement($remarkForMe)) {
                // set the owning side to null (unless already changed)
                if ($remarkForMe->getAuthor() === $this) {
                    $remarkForMe->setAuthor(null);
                }
            }

            return $this;
        }
    }
}
