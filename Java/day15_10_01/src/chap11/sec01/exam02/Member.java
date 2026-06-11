package chap11.sec01.exam02;

import java.util.Objects;

public class Member {
	public String id;

	public Member(String id) {
		this.id = id;
	}
//	@Override
//	public boolean equals(Object obj) {
//		Member mem = (Member) obj;
//		return this.id.equals(mem.id);
//	}

	@Override
	public int hashCode() {
		return Objects.hash(id);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Member other = (Member) obj;
		return Objects.equals(id, other.id);
	}

	@Override
	public String toString() {
		return "Member [id=" + id + "]";
	}
}